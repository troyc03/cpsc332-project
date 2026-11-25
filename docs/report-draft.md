# UN World Database Investigation: Report Draft

**Team name:** [Insert]  
**Course:** CPSC 332, Fall 2026  
**Team members:** [Insert all members]  
**Date:** [Insert]

> Draft scaffold: replace bracketed fields with your team's verified observations and decisions. Do not report synthetic sample values as official data. Include the actual result tables/screenshots and row counts from MySQL.

## 1. Introduction

The project investigates a relational database built around the supplied World teaching database, which contains country, city, and country-language information. The team extends the original schema with country-year economic, health, and education indicators to support broader comparisons across countries. The objective is to practice relational modeling, constraints, SQL joins, subqueries, and data interpretation using a scenario framed around international development questions.

Economic conditions, health-system resources, and education indicators describe different dimensions of development and are useful for exploratory comparisons. The added entities allow these measures to be stored separately while connected to the original Country entity. The team’s questions investigate associations among the indicators and demographic attributes. These comparisons are descriptive and do not establish causation.

**Project scope and questions:** [Describe the team's final research questions and why they were selected. Cite the official data sources actually used.]

## 2. Database Development Process

### 2.1 Original schema and added entities

The base World schema provides Country, City, and CountryLanguage. The extension introduces EconomicIndicator, HealthIndicator, and EducationIndicator. Each added entity records country-level observations by year. The composite primary key CountryCode + IndicatorYear prevents duplicate records for the same country/year within each domain. CountryCode references Country.Code, providing referential integrity.

The team separated economic, health, and education attributes into distinct tables rather than combining unrelated measures into one wide table. This design makes each domain easier to maintain and allows the schema to accommodate annual observations. The Country entity acts as the parent for the three added indicator tables.

### 2.2 Keys and constraints

The base Country table uses Code as its primary key. The City entity uses ID, and CountryLanguage uses the combination of CountryCode and Language. Each additional indicator entity uses a composite key consisting of CountryCode and IndicatorYear and includes a foreign key to Country.Code. CHECK constraints restrict years and numeric rates to reasonable ranges. [Confirm these constraints were tested in your MySQL version and describe any changes.]

### 2.3 ER diagram and relational models

[Insert the team's updated ER diagram and physical model images.]

Explain the one-to-many relationships from Country to City, CountryLanguage, and each indicator table. Include the logical schema and physical implementation details, including data types, primary keys, foreign keys, and integrity rules.

### 2.4 Data and limitations

The initial extension script includes illustrative dummy indicator values for query development. They are not official measurements and must not be cited as factual national statistics. The base World teaching dataset is historical, while the extension sample uses 2023 as its observation year; temporal mismatch means comparisons should not be treated as perfectly aligned. The final team should either replace sample values with traceable source observations, or clearly disclose the dummy-data approach allowed by the assignment and restrict conclusions accordingly.

For each final source, document the indicator definition, country, year, units, source URL, and retrieval date. [Insert sourced-data method and details.]

## 3. Database Investigation

The assignment requires 20 investigations, with 10 JOIN-oriented and 10 subquery-oriented queries, and at least four returned rows for each query. The team must execute the queries against the actual database, record row counts, and include evidence.

For each query below, fill in: (1) the question and purpose, (2) final SQL, (3) returned row count and output evidence, and (4) interpretation supported by the results. Avoid causal claims.

### 3.1 JOIN investigations (Q01-Q10)

**Q01. Country development profile.** Compare economic, health, and education indicators across countries.  
**Purpose and significance:** [Explain what this multi-domain profile helps compare.]  
**Validated row count / output:** [Insert evidence.]  
**Interpretation:** [Write based on the verified output.]

**Q02. National population and city scale.** Compare national population and GDP per capita with listed city counts and largest-city population.  
**Purpose and significance:** [Explain the question.]  
**Validated row count / output:** [Insert evidence.]  
**Interpretation:** [Verified result only.]

**Q03. Official language, literacy, and education investment.** Explore how official-language records relate to education indicators.  
**Purpose and significance:** [Explain; do not imply language causes literacy.]  
**Validated row count / output:** [Insert evidence.]  
**Interpretation:** [Verified result only.]

**Q04. Health resources by continent.** Compare health spending and physician availability across countries and continents.  
**Purpose and significance:** [Explain relevance.]  
**Validated row count / output:** [Insert evidence.]  
**Interpretation:** [Verified result only.]

**Q05. City population and national health indicators.** Compare large listed cities with national health resources.  
**Purpose and significance:** [Explain the national-vs-city limitation.]  
**Validated row count / output:** [Insert evidence.]  
**Interpretation:** [Verified result only.]

**Q06. Urban population, income, and poverty.** Explore large cities in countries with differing economic indicators.  
**Purpose and significance:** [Explain.]  
**Validated row count / output:** [Insert evidence.]  
**Interpretation:** [Verified result only.]

**Q07. Education expenditure and tertiary enrollment.** Compare education spending, enrollment, literacy, and income.  
**Purpose and significance:** [Explain.]  
**Validated row count / output:** [Insert evidence.]  
**Interpretation:** [Verified result only.]

**Q08. Language-share and poverty comparison.** Compare official-language records and country poverty/income values.  
**Purpose and significance:** [Discuss demographic context and limitations.]  
**Validated row count / output:** [Insert evidence.]  
**Interpretation:** [Verified result only.]

**Q09. Country population, listed cities, and education.** Compare city coverage and education measures.  
**Purpose and significance:** [Explain the meaning of city records and coverage.]  
**Validated row count / output:** [Insert evidence.]  
**Interpretation:** [Verified result only.]

**Q10. Integrated language, city, health, and income profile.** Combine several domains for exploration.  
**Purpose and significance:** [Explain the multidimensional policy use.]  
**Validated row count / output:** [Insert evidence.]  
**Interpretation:** [Verified result only.]

### 3.2 Subquery investigations (Q11-Q20)

**Q11. Above-average GDP per capita.** Identify countries above the sample's mean GDP per capita and compare physician availability.  
[Insert final SQL, tested row count, output, interpretation.]

**Q12. Literacy relative to the sample minimum.** Examine literacy, education expenditure, and language records.  
[Insert final SQL, tested row count, output, interpretation.]

**Q13. Above-average poverty and listed-city existence.** Find countries above sample-average poverty that have a City record.  
[Insert final SQL, tested row count, output, interpretation.]

**Q14. Countries with city records and health observations.** Use a subquery to filter countries represented by cities.  
[Insert final SQL, tested row count, output, interpretation.]

**Q15. GDP per capita above the sample minimum.** Explore education outcomes across countries above the minimum GDP-per-capita observation.  
[Insert final SQL, tested row count, output, interpretation.]

**Q16. Official-language record and positive share.** Pair language records with health and education data using a subquery.  
[Insert final SQL, tested row count, output, interpretation.]

**Q17. Countries above the World-table population average.** Compare population scale with health and economic indicators.  
[Insert final SQL, tested row count, output, interpretation.]

**Q18. Countries with positive listed-city population totals.** Compare education indicators among countries whose City population sum is positive.  
[Insert final SQL, tested row count, output, interpretation.]

**Q19. Education expenditure at or above the sample minimum.** Compare expenditure, literacy, poverty, and population.  
[Insert final SQL, tested row count, output, interpretation.]

**Q20. Official-language existence and health/income.** Summarize health and income measures for countries with official-language records.  
[Insert final SQL, tested row count, output, interpretation.]

## 4. Summary

[Summarize verified patterns from the query outputs. Discuss the most interesting observations, technical challenges, schema choices, query-writing lessons, and limitations. Mention which conclusions are descriptive only. Do not invent findings.]

## References

Add APA-formatted references for the official sources the team actually accessed and used, along with any course materials cited. Candidate source portals are listed in `docs/data-sources.md`; confirm exact indicator definitions and retrieved observations before citing them.
