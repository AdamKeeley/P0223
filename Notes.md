# MRC CiC Auto-immune Covid-19

## Data
- UK Biobank
	- full cohort diagnosed with Covid-19 who were alive on 2021-01-01
	- uses 
- TPP
	- GP data
	- subset of UKB
	- uses CTV3
- Emis
	- GP data
	- subset of UKB
	- uses 
- Lookups
	- Diagnosis
		- used to define patients with the autoimmune diseases and covariates of interest
		- some still need code lists generating
	- Medication 
		- single file list of terms
		- grouped into categories
			- IS_DMARD
			- NonIS_DMARD
			- Oral_GC

## Analysis files
Use same logic as used in P0090 - GAE where possible.

- Sociodemographic and health habit 
	- long file
	- use whole cohort from UKB
	- include all values captured between two years prior to extration date and date of death, de-registration, etc.
	- Take smoking status, BMI from GP data
	- Deprivation Index from GP practice location?
	- **Let team know what is in GP Registration file**
	
- Disease
	- one file per disease
	- long files
	- criteria
		- include if disease present at any point prior to 2020-01-01
	- include fields 
		- patient id
		- diagnosis code
		- diagnosis date
		- indicate data source
- Medication
	- one file per medication group
	- long files
	- criteria 
		- include if prescription occurs 2 years prior to extraction date
	- include fields 
		- patient id
		- medication
		- prescription date
		- administration method (route)?
		- stop date/duration?
		- dose?
		- indicate data source
	- **Let team know what's in the data**

## Project locations

### DAT team folder:
N:\Academic-Services\ISS\IRC-Data-Services\Projects\P0223 - Biobank Autoimmune Disease Covid-19

### Root folder
N:\Faculty-of-Medicine-and-Health\LIRMM\Molecular Rheumatology\GCA Molecular data\UK BioBank AID GC toxicity

### Raw UK Biobank assessment data
N:\Faculty-of-Medicine-and-Health\LIRMM\Molecular Rheumatology\GCA Molecular data\UK BioBank AID GC toxicity\UKBioBank\Data\ukb44045.csv

### Crossfield's WD
N:\Faculty-of-Medicine-and-Health\LIRMM\Molecular Rheumatology\GCA Molecular data\UK BioBank AID GC toxicity\SC  
	- Code Lists: 
		- contains CTV3 and ReadV2 folders that have diagnosis / smoking status / BMI codelists (as discussed, BMI is most likely best calculated from weight)  
	- Documents: 
		- contains the study protocol (an evolving document, it would be good to update with detail as the analysis plan becomes clearer and update the table of diagnosis codelists when new ones are made)  
	- Lookups:
		- UKBB_Medication.csv 
			- lists drug names (from Biobank) that have been identified as belonging in a group. 
			- Group2 indicates the drugs that are in IS_DMARD, NonIS_DMARD and oral_GC, which are the drugs of interest.
		- In DrugTerm.csv 
			- UKBB_Medication stripped of all references to dosage (e.g. 10 mg) from the drug names to create a cleaner list for querying using a LIKE statement.
	- Outputs: 
		- files SC made for AM and MR, in case they refer to anything. 44045UKBB_Medication_V2.xlsx is the file used to make the above UKBB_Medication.csv (i.e. it contains additional researcher comments and column names that are readable e.g. have spaces in)
	- SQL databases:
		- CiC..StudyPopulation 
			- all UKB patients eligible for this study
		- AID_GC..IndexCovid 
			- 9k UKB patients with covid-19
			– this is our study cohort
			- it has their index date (date of covid diagnosis).

We want to identify patients with autoimmune inflammatory disease (AID) and/or an immunosuppressant / DMARD drug. SC has identified these from the UKB baseline assessment data, but is hoping that by searching the GP data AK will be able to increase the cohort sizes!  

Identified from UKB:
		- CiC..Cohort_Covid_AID  
			- patients with Covid and an AID identified from assessment data (the AID is listed)
		- CiC.. Cohort_Covid_IS  
			- patients with Covid and a IS_DMARD, NonIS_DMARD or oral_GC  identified from assessment data
		- CiC.. Cohort_Covid_IS_NoAID  
			- patients in the above table who do not have an AID
