# Source Data
[Data for COVID-19 research](https://biobank.ndph.ox.ac.uk/showcase/exinfo.cgi?src=COVID19).

## UK Biobank
- ukb44045.csv
- full cohort diagnosed with Covid-19 who were alive on 2020-01-01


## Study withdrawals
- w24559_20210201.csv
- uploaded to **P0223.dbo.study_withdrawals**  

Anonymised IDs of participants who have requested that their data should no longer be used and any others who have withdrawn previously. 
**Corresponding records have been removed from source data and therefore excluded from further analyses.**

## Primary care (GP) data  
Details on the structure of the GP data can be found in Section 4.4 (page 10) of [Resource 3151](https://biobank.ndph.ox.ac.uk/showcase/showcase/docs/gp4covid19.pdf).  

Currently stored on N: here:  
N:\Faculty-of-Medicine-and-Health\LIRMM\Molecular Rheumatology\GCA Molecular data\UK BioBank AID GC toxicity\UKBioBank\Data\Covid-19  

### Codes used   
|Code type|Used in|Available from|Uploaded to|
|---|---|---|---|
|SNOMED |covid19_emis_gp_clinical|TRUD|P0223.tlk.SNOMED_Concept|
|	|	|	|P0223.tlk.SNOMED_Description|
|dm+d |covid19_emis_gp_scripts|TRUD|	|
|	|covid19_tpp_gp_scripts|TRUD|	|
|CTV3 |covid19_tpp_gp_clinical|UKB ([7128](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=7128))|P0223.tlk.CTV3_clinical_codes|
|EMIS Clinical|covid19_emis_gp_clinical|UKB ([7689](https://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=7689))|P0223.tlk.EMIS_clinical_codes|
|EMIS Prescription |covid19_emis_gp_scripts|UKB ([7678](https://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=7678))|P0223.tlk.EMIS_prescription_codes|
|TPP Clinical |covid19_tpp_gp_clinical|UKB ([8708](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=8708))|P0223.tlk.TPP_clinical_codes|


### Clinical
- EMIS
	- covid19_emis_gp_clinical.txt  
	- uploaded to **P0223.dbo.covid19_emis_gp_clinical**
		|Table Name|Field Name|Description|Encoding|
		|---|---|---|---|
		|covid19_emis_gp_clinical|eid|Participant identifier |NA|
		| |event_dt|Date clinical code entered|Special dates in tlk.special_values (where code_set = [819](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=819))|
		| |code|Clinical code|SNOMED codes available from TRUD. <br/>EMIS Local: tlk.EMIS_clinical_codes ([7689](https://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=7689))|
		| |code_type|SNOMED or EMIS Local code|tlk.gp_code_type ([3175](https://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=3175))|
		| |value|Value recorded |Special values in tlk.special_values (where code_set = [2360](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=2360))|
		| |unit|Unit recorded for value|Special codes in tlk.special_values (where code_set = [1176](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=1176))|
- TPP
	- covid19_tpp_gp_clinical.txt 
	- uploaded to **P0223.dbo.covid19_tpp_gp_clinical** 
		|Table Name|Field Name |Description|Encoding|
		|---|---|---|---|
		|covid19_tpp_gp_clinical|eid|Participant identifier|NA|
		| |event_dt |Date clinical code entered |Special dates in tlk.special_values (where code_set = [819](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=819))|
		| |code |Clinical code |CTV3: tlk.CTV3_clinical_codes ([7128](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=7128)) <br/>TPP Local: tlk.TPP_clinical_codes ([8708](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=8708))|
		| |code_type |CTV3 or local TPP code |tlk.gp_code_type ([3175](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=3175))|
		| |value |Value recorded |Special codes in tlk.special_values (where code_set = [5702](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=5702))|

### Prescription
- EMIS
	- covid19_emis_gp_scripts.txt 
	- uploaded to **P0223.dbo.covid19_emis_gp_scripts** 
		|Table Name|Field Name |Description|Encoding|
		|---|---|---|---|
		|covid19_emis_gp_scripts|eid |Participant identifier |NA |
		| |issue_date |Date clinical code entered |Special dates in tlk.special_values (where code_set = [819](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=819))|
		| |code |Clinical code |dm+d codes available from TRUD <br/>tlk.EMIS_prescription_codes ([7678](https://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=7678))|
		| |code_type |dm+d or EMIS Local code|tlk.gp_code_type ([3175](https://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=3175))|
- TPP 
	- covid19_tpp_gp_scripts.txt 
	- uploaded to **P0223.dbo.covid19_tpp_gp_scripts** 
		|Table Name|Field Name |Description|Encoding|
		|---|---|---|---|
		|covid19_tpp_gp_scripts |eid |Participant identifier |NA |
		| |issue_date |Date clinical code entered |Special dates in tlk.special_values (where code_set = [819](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=819)) |
		| |dmd_code |Clinical code |dm+d codes available from TRUD <br/>Special values in tlk.special_values (where code_set = [4214](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=4214)) |
	
### Lookups
- Diagnosis
	- used to define patients with the autoimmune diseases and covariates of interest
	- some still need code lists generating
		- [Manchester clinical codes repository](https://clinicalcodes.rss.mhs.man.ac.uk/)
		- Full list of all Read2 codes: N:\Faculty-of-Medicine-and-Health\LIRMM\Molecular Rheumatology\GCA Molecular data\UK BioBank AID GC toxicity\SC\Lookups\ReadV2_CodeDictionary
- Medication 
	- single file list of terms
	- grouped into categories
		- IS_DMARD
		- NonIS_DMARD
		- Oral_GC
		- Local_GC
