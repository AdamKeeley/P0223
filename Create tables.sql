--create database P0223
--go

use P0223
go

/********************
	DATA TABLES
********************/
create table dbo.study_withdrawals (
	eid bigint
	constraint PK_study_withdrawals primary key (eid)
	)

create table dbo.covid19_emis_gp_clinical (
	eid bigint
	, event_dt datetime
	, code varchar(255)
	, code_type int
	, [value] bigint
	, unit varchar(12)
	)

create table dbo.covid19_tpp_gp_clinical (
	eid bigint
	, event_dt datetime
	, code varchar(255)
	, code_type int
	, [value] bigint
	)

create table dbo.covid19_emis_gp_scripts (
	eid bigint
	, issue_date datetime
	, code varchar(30)
	, code_type int
	)

alter table dbo.covid19_emis_gp_scripts
alter column code varchar(30)

create table covid19_tpp_gp_scripts (
	eid bigint
	, issue_date datetime
	, dmd_code  varchar(18)
	)



/********************
	LOOKUP TABLES
********************/
--create schema tlk
--go

create table tlk.EMIS_prescription_codes (
	coding varchar(255)
	, meaning varchar(max)
	)

create table tlk.EMIS_clinical_codes (
	coding varchar(255)
	, meaning varchar(max)
	)

create table tlk.CTV3_clinical_codes (
	coding varchar(5)
	, meaning varchar(max)
	)

create table tlk.TPP_clinical_codes (
	coding varchar(5)
	, meaning varchar(max)
	)

create table tlk.gp_code_type (
	coding int
	, meaning varchar(55)
	constraint PK_gp_code_type primary key (coding)
	) 

create table tlk.special_values (
	code_set int
	, coding varchar(255)
	, meaning varchar(255)
	constraint PK_special_values primary key (code_set, coding)
	)

insert into tlk.special_values values 
  (819 , '1900-01-01', 'Code has no event date')
, (819 , '1901-01-01', 'Code has event date before participants date of birth')
, (819 , '1902-02-02', 'Code has event date matching participants date of birth')
, (819 , '1903-03-03', 'Code has event date after participants date of birth and falls in the same calendar year as date of birth')
, (819 , '2037-07-07', 'Code has event date in the future and is presumed to be a place-holder or other system default')

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

insert into tlk.special_values values 
 (2360, -9999999	, 'empty or non-numeric value/unit')
,(2360, -9000099	, 'associated with empty or 0 clinical code')
,(2360, -9000004	, 'redacted - incorrect READ2')
,(2360, -9000003	, 'redacted - incorrect SNOMED')
,(2360, -9000002	, 'redacted - rare occupation')
,(2360, -9000001	, 'redacted - potentially sensitive or identifying')

insert into tlk.special_values values
  (1170, -9000001	, 'redacted - potentially sensitive or identifying')
, (1170, -9000002	, 'redacted - rare occupation')
, (1170, -9000003	, 'redacted - incorrect SNOMED')
, (1170, -9000004	, 'redacted - incorrect READ2')
, (1170, -9000099	, 'associated with empty or 0 clinical code')
, (1170, -9999999	, 'empty unit')

insert into tlk.special_values values 
 (5702, -1	, 'redacted - potentially sensitive or identifying')
,(5702, -2	, 'redacted - rare occupation')

insert into tlk.special_values values 
 (4214, -1, 'No dm+d code')
,(4214, -2, 'Mapped to multiple dm+d codes')

