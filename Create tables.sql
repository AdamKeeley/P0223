/********************
	DATA TABLES
********************/
create table dbo.covid19_emis_gp_clinical (
	eid bigint
	, event_dt datetime
	, code varchar(255)
	, code_type int
	, [value] bigint
	, unit varchar(12)
	)

--create table dbo.covid19_tpp_gp_clinical (
--	eid bigint
--	, event_dt datetime
--	, code 
--	, code_type
--	, [value]
--	, unit
--	)

--create table dbo.covid19_emis_gp_scripts (
--	eid bigint
--	, issue_date datetime
--	, code 
--	, code_type
--	)

--create table covid19_tpp_gp_scripts (
--	eid bigint
--	, issue_date datetime
--	, dmd_code 
--	)



/********************
	LOOKUP TABLES
********************/
--create schema tlk
--go

create table tlk.special_dates (
	coding date
	, meaning varchar(125)
	constraint PK_special_dates primary key (coding)
	)

insert into tlk.special_dates values 
('1900-01-01', 'Code has no event date')
, ('1901-01-01', 'Code has event date before participants date of birth')
, ('1902-02-02', 'Code has event date matching participants date of birth')
, ('1903-03-03', 'Code has event date after participants date of birth and falls in the same calendar year as date of birth')
, ('2037-07-07', 'Code has event date in the future and is presumed to be a place-holder or other system default')

create table tlk.gp_code_type (
	coding int
	, meaning varchar(55)
	constraint PK_gp_code_type primary key (coding)
	) 

insert into tlk.gp_code_type values
  (0	, 'CTV3')
, (1	, 'Local TPP code')
, (2	, 'SNOMED CT')
, (3	, 'Local EMIS code')
, (-1	, 'redacted - potentially sensitive or identifying')
, (-2	, 'redacted - rare occupation')
, (-3	, 'redacted - incorrect SNOMED')
, (-4	, 'redacted - incorrect READ2')
, (5	, 'EMIS online test request code (OLTR)')
, (6	, 'dm+d')
, (-99	, 'redacted - missing')

create table tlk.special_values (
	coding int
	, meaning varchar(60)
	constraint PK_special_values primary key (coding)
	)

insert into tlk.special_values values 
(-9999999	, 'empty or non-numeric value/unit')
,(-9000099	, 'associated with empty or 0 clinical code')
,(-9000004	, 'redacted - incorrect READ2')
,(-9000003	, 'redacted - incorrect SNOMED')
,(-9000002	, 'redacted - rare occupation')
,(-9000001	, 'redacted - potentially sensitive or identifying')

create table tlk.special_units (
	coding int
	, meaning varchar(60)
	constraint PK_special_units primary key (coding)
	)

insert into tlk.special_units values
 (-9000001	, 'redacted - potentially sensitive or identifying')
, (-9000002	, 'redacted - rare occupation')
, (-9000003	, 'redacted - incorrect SNOMED')
, (-9000004	, 'redacted - incorrect READ2')
, (-9000099	, 'associated with empty or 0 clinical code')
, (-9999999	, 'empty unit')


