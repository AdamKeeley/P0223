# Code Lists

## Covariates
There are eighteen covariates of interest, coded across four systems. 

### SNOMED
Hierarchical parent/child (destination/source) relationship between conceptIDs.  
- Concepts in **[tlk].[SNOMED_Concept]**, `where active = 1`.  
- Concept descriptions defined in **[tlk].[SNOMED_Description]**, `where active = 1`.  
  - Each Concept has many 'Alias' descriptions but supposedly a single Fully Specified Name (FSN)
- Relationships between concepts defined in **[tlk].[SNOMED_Relationship]**, `where active = 1 and typeId = 116680003` ('Is a' relationship).  

Set of search terms for each Covariate provided by SC.  
Used to search against all FSN & Alias descriptions to create a set of 'Parent' Concepts.  
The 'Child' Concepts for these were found, recursing down the full chain to get all related Concepts.  
Concepts and their FSNs were returned and sent to SC for intial review and grouping.
- Previously approved SNOMED Concepts included and marked as such
- Any Concepts not included in the data excluded from review (reducing reviewable code count from >86k to <17k)

<details>
  <summary>Code to generate SNOMED covariate code lists: </summary>
  
  ```TSQL
  ALTER proc [dbo].[sp_search_Child_SNOMED] (@covariate varchar(max))
  as

  declare @core table (ConceptId bigint)
  declare @child table (ConceptId bigint)

  -- Get core ConceptIDs
  insert into @core
  select distinct c.id
  from [tlk].[SNOMED_Concept] c
    inner join [tlk].[SNOMED_Description] d
      on c.id = d.conceptId
    inner join [tlk].[code_list_search_terms] s
      on d.term like '%' + upper(s.term) + '%'
  where c.active = 1
    and d.active = 1
    and s.covariate = @covariate


  -- Get the children of the core
  ;with tblChild as
    (
      select r.*  -- parent codes
      from [tlk].[SNOMED_Relationship] r
        inner join [tlk].[SNOMED_Concept] c
          on r.destinationId = c.id
      where r.[destinationId] in (select ConceptId from @core)
        and r.typeId = 116680003  -- 'Is a' relationship
        and r.active = 1
        and c.active = 1
    union all
      select r.*  -- child codes
      from [tlk].[SNOMED_Relationship] r
        inner join [tlk].[SNOMED_Concept] c
          on r.sourceId = c.id
        inner join tblChild 
          on r.[destinationId] = tblChild.sourceId
      where r.typeId = 116680003  -- 'Is a' relationship
        and r.active = 1
        and c.active = 1
    )
  insert into @child
  select distinct sourceId
  from tblChild
  option(MAXRECURSION 32767)

  -- return conceptId and FSN term
  select distinct @covariate as covariate
    , 'SNOMED' as code_type
    , c.id as conceptId
    , d.term
  from [tlk].[SNOMED_Concept] c
    inner join [tlk].[SNOMED_Description] d
      on c.id = d.conceptId
  where c.active = 1
    and d.active = 1
    and d.typeId = 900000000000003001 -- FSN
    and c.id in (select conceptId from @child union all select conceptId from @core)
  order by c.id, d.term
  ```
</details>

### CTV3
Hierarchical parent/child relationship between concepts. Need to perform similar to SNOMED above.

### EMIS Local
Non hierarchical, term search and review should suffice.

### TPP Local
Non hierarchical, term search and review should suffice.

## Medications
