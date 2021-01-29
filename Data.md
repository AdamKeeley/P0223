# UK Biobank Data
[Data for COVID-19 research](https://biobank.ndph.ox.ac.uk/showcase/exinfo.cgi?src=COVID19).

## UK Biobank
- ukb44045.csv
- full cohort diagnosed with Covid-19 who were alive on 2021-01-01
- coded using ICD-10?

## Primary care (GP) data  
Details on the structure of the GP data can be found in Section 4.4 (page 10) of [Resource 3151](https://biobank.ndph.ox.ac.uk/showcase/showcase/docs/gp4covid19.pdf).  

Currently stored on N: here:  
N:\Faculty-of-Medicine-and-Health\LIRMM\Molecular Rheumatology\GCA Molecular data\UK BioBank AID GC toxicity\UKBioBank\Data\Covid-19  

### Clinical
- EMIS
	- covid19_emis_gp_clinical.txt  
		|Table Name|Field Name |Description|Encoding|
		|---|---|---|---|
		|covid19_emis_gp_clinical|eid|Participant identifier |NA|
		||event_dt|Date clinical code entered|Special codes in Data-Coding 819|
		||code|Clinical code|SNOMED codes available from TRUD EMIS Local Clinical Code List DataCoding 7689|
		||code_type|SNOMED or EMIS Local code|Data-Coding 3175|
		||value|Value recorded |Special codes in Data-Coding 2360|
		||unit|Unit recorded for value|Special codes in Data-Coding 1176|
- TPP
	- covid19_tpp_gp_clinical.txt 
		|Table Name|Field Name |Description|Encoding|
		|---|---|---|---|
		|covid19_tpp_gp_clinical|eid|Participant identifier|NA|
		||event_dt |Date clinical code entered |Special codes in Data-Coding 819|
		||code |Clinical code |CTV3: Data-Coding 7128 Local TPP: Data-Coding 8708|
		||code_type |CTV3 or local TPP code Data-Coding 3175|
		||value Value |recorded Special codes in Data-Coding 5702|

### Prescription
- EMIS
	- covid19_emis_gp_scripts.txt  
	- subset of UKB
	- coded using Read2	
- TPP 
	- covid19_tpp_gp_scripts.txt 
	- subset of UKB
	- coded using CTV3
	
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