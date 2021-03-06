# SQL Queries

Exclude all records with the following code_type:
|coding	|meaning											|
|---	|---                                                |
|-99	|redacted - missing                                 |
|-4		|redacted - incorrect READ2                         |
|-3		|redacted - incorrect SNOMED                        |
|-2		|redacted - rare occupation                         |
|-1		|redacted - potentially sensitive or identifying    |

## Clinical (EMIS)

Created a view that de-normalises the data into human readable format, **dbo.vw_covid19_emis_gp_clinical**.
Can then just inner join code lists to view when generating analysis files.
Data volume might require that the result set of the view be written to a table however.

Need to understand how SNOMED works, and how it all fits in with what code lists already exists.

Is as the following so far:
```SQL
use P0223
go

alter view dbo.vw_covid19_emis_gp_clinical
as

SELECT [eid]
	, case when sp_dt.coding is not null 
		then sp_dt.meaning
		else format([event_dt], 'yyyy-MM-dd') end as [event_dt]
	, [code]
	, ct.[meaning] as code_type
	, case when code_type = 2 then '?' --snomed.description
		when code_type in (3, 5) then emis.meaning
		end as code_desc
	, case when sp_va.coding is not null
		then sp_va.meaning
		else cast([value] as varchar(255)) end as [value]
	, case when sp_un.coding is not null 
		then sp_un.meaning
		else [unit] end as [unit]
FROM [P0223].[dbo].[covid19_emis_gp_clinical] cl
	left join (
		select * from [tlk].[special_values] where code_set = 819) sp_dt
		on cl.event_dt = sp_dt.coding
	/*
	SNOMED TABLES GO HERE
	*/
	left join [tlk].[EMIS_clinical_codes] emis
		on cl.code = emis.coding
	left join [tlk].[gp_code_type] ct
		on cl.code_type = ct.coding
	left join (
		select * from [tlk].[special_values] where code_set = 2360) sp_va
		on cl.[value] = sp_va.coding
	left join (
		select * from [tlk].[special_values] where code_set = 1176) sp_un
		on cl.[unit] = sp_un.coding

where cl.code_type not in (-99, -4, -3, -2, -1)
```
