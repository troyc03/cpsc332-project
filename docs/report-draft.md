# UN World Database Investigation

**Team:** [Confirm team/project name]  
**Course:** CPSC 332, Fall 2026  
**Team members:** Troy Chin, Dominik Pelikan, Mohit Sharma, Armin Tehrani  
**Draft date:** November 26, 2026

> **Submission status:** This narrative draft is prepared, but local database execution, actual row counts, result screenshots, verified findings, updated ERD/physical-model images, and final Word formatting remain. Do not invent findings. The Word submission must use APA style, 12-point Times New Roman, double spacing, and at least four body pages excluding title and references.

## Introduction

This project extends the MySQL World teaching database to investigate relationships among country demographics, urban records, language data, and economic, health, and education indicators. The project is framed as a database investigation for an international organization interested in comparing country-level conditions and identifying questions for further research. The original schema contains Country, City, and CountryLanguage. We add EconomicIndicator, HealthIndicator, and EducationIndicator to organize development measures.

Population, city records, languages, income, poverty, education, and health measures describe different aspects of a country's context. Combining them can support descriptive comparisons, but an association in this sample does not establish that one factor causes another. The investigations demonstrate relational queries and frame questions rather than make policy claims.

The added indicator tables currently contain illustrative sample values for 16 countries in 2023. These values are synthetic and are not official measurements. The classic World database is a teaching dataset and may reflect a different time period. The combined data therefore has temporal and representational limitations.

## Database Development Process

### Original schema and extension

The base World database includes Country, City, and CountryLanguage. Country stores national attributes such as country code, name, continent, region, population, life expectancy, GNP, and capital. City stores city identifiers, names, country codes, districts, and population. CountryLanguage records languages associated with countries, including official status and percentage.

The project adds three tables. EconomicIndicator stores GDP per capita, unemployment rate, and poverty rate. HealthIndicator stores health expenditure as a percentage of GDP, physician density, and maternal mortality. EducationIndicator stores literacy, education expenditure, and tertiary enrollment. Each added table records a country and an observation year. The country-year design allows multiple annual observations rather than overwriting values as indicators change.

### Keys, relationships, and integrity

Country.Code is the parent key. City.ID is the City primary key, and CountryLanguage uses CountryCode and Language as its composite key in the supplied World schema. Each new indicator table uses the composite primary key (CountryCode, IndicatorYear), preventing duplicate observations for the same country and year within a domain. CountryCode in each indicator table references Country.Code. The added foreign keys use update cascading and restrict country deletion while dependent observations exist.

The extension includes CHECK constraints for observation years, nonnegative quantities, and percentage ranges. These rules reduce invalid values and support consistent interpretation. DECIMAL types are used for indicator measures. The three indicator tables are separate because economic, health, and education measurements represent distinct domains with different attributes.

### Logical and physical models

The logical model centers on Country and connects it to City, CountryLanguage, and the three added indicator entities. Country has one-to-many relationships with the child tables: a country may have many city records, language records, and annual indicator observations. The physical model specifies column types, keys, constraints, and implementation details. The logical ERD is documented in `docs/erd-logical.md`; the SQL implementation is in `sql/01_additional_tables.sql`.

**Insert the team's updated ER diagram and physical model images here.** Update the editable Workbench model and export a matching diagram before submission; the original diagram is not evidence of the completed extension.

### Data and limitations

The extension seed data is illustrative, not sourced statistics, and must not be attributed to the World Bank, United Nations, or another organization. The repository includes a retrieval script that collects World Bank observations into a provenance CSV; it does not load those observations into MySQL. Before replacing sample rows, the team must choose actual observations, handle missing values, align years across indicators, update the SQL, and document source, units, year, URL, and retrieval date. The current sample is small and nonrandom, and the base World records and 2023 sample may not be temporally aligned. Country-level measures joined to city or language records remain national measures, not city- or language-level outcomes.

## Database Investigation

The SQL file `sql/02_investigation_queries.sql` contains 20 queries: Q01–Q10 are JOIN-oriented and Q11–Q20 are subquery-oriented. Each query combines at least one original World table with one added indicator table. The course requires every query to return at least four rows. This requirement must be checked on the team's actual MySQL installation. The complete SQL is preserved in the repository query file and in `docs/query-appendix.md`; copy/include the query text in the Word report.

### JOIN investigations (Q01–Q10)

| Query | Research question and purpose |
|---|---|
| Q01 | Build a country development profile by joining economic, health, and education indicators. |
| Q02 | Compare national population and GDP per capita with the count and largest population of listed cities. |
| Q03 | Explore official-language records alongside literacy and education spending. Language records are demographic context, not evidence that language causes literacy. |
| Q04 | Compare health spending, physician density, and maternal mortality across continents. |
| Q05 | Compare large listed cities with country-level physician density and health spending; these are national measures. |
| Q06 | Relate listed city populations to country-level GDP per capita and poverty sample values. |
| Q07 | Compare education expenditure, tertiary enrollment, literacy, and income. |
| Q08 | Explore official-language population shares in the context of country-level poverty and income. |
| Q09 | Compare country population and listed-city coverage with literacy and tertiary enrollment. City coverage may reflect source coverage, not a complete urban census. |
| Q10 | Integrate official-language records, city counts, health resources, and income into a multi-domain comparison. |

### Subquery investigations (Q11–Q20)

| Query | Research question and purpose |
|---|---|
| Q11 | Identify sample countries above sample-average GDP per capita and compare physician density. |
| Q12 | Find countries above sample-average literacy and examine education spending and language records. |
| Q13 | Identify countries above sample-average poverty that have at least one listed city. |
| Q14 | Select countries represented by populated city records and compare health and income indicators. |
| Q15 | Select countries above sample-average GDP per capita and compare literacy and tertiary enrollment. |
| Q16 | Compare each official language's listed share with the within-country average official-language share, alongside health and literacy. |
| Q17 | Identify countries above the World-table population average and compare health resources and poverty sample values. |
| Q18 | Use a correlated subquery to select countries with a positive total listed city population and compare education and income. |
| Q19 | Identify countries above sample-average education expenditure and compare literacy, poverty, and population. |
| Q20 | Use EXISTS to select countries with official-language records and compare maternal mortality, health expenditure, and income. |

### Query validation and findings

**Validation record:** Run Q01–Q20 against the team's MySQL database. Record MySQL version, date, tester, actual row count for every query, whether it meets the minimum of four, and errors/fixes. Attach screenshots or exports. Use `docs/validation-results-template.md`.

| Query group | Required validation | Status |
|---|---|---|
| Q01–Q10 JOIN queries | Run all 10; each must return at least 4 rows | Pending local execution |
| Q11–Q20 subquery queries | Run all 10; each must return at least 4 rows | Pending local execution |

**Results interpretation:** [Insert only observations supported by actual output. Describe patterns and exceptions, not causal explanations. Do not present synthetic values as official national statistics.]

## Summary

The project demonstrates how a relational schema can connect a central Country entity with demographic, urban, language, and annual indicator information. The added country-year tables illustrate composite keys, foreign keys, integrity constraints, and domain separation. The 20 investigations practice joins, subquery filters, grouping, and sample-average comparisons.

A key technical lesson is that query logic and data assumptions must be checked together. Joining annual indicators requires year alignment, and joining country-level measures to city or language records can multiply rows. Aggregate queries must account for that multiplicity, while comparisons must respect each table's data grain. The final report should include verified row counts and output-based findings after local execution. Remaining limitations include synthetic sample values, the selected country sample, historical base data, temporal mismatch, and the absence of causal analysis.

## References

World Bank. (n.d.). *World Development Indicators*. https://databank.worldbank.org/source/world-development-indicators

World Bank. (n.d.). *World Bank API documentation*. https://datahelpdesk.worldbank.org/knowledgebase/articles/889392

World Bank. (n.d.). *GDP per capita (current US$)*. https://data.worldbank.org/indicator/NY.GDP.PCAP.CD

World Bank. (n.d.). *Unemployment, total (% of labor force)*. https://data.worldbank.org/indicator/SL.UEM.TOTL.ZS

World Bank. (n.d.). *Current health expenditure (% of GDP)*. https://data.worldbank.org/indicator/SH.XPD.CHEX.GD.ZS

World Bank. (n.d.). *Literacy rate, adult total (% of people ages 15 and above)*. https://data.worldbank.org/indicator/SE.ADT.LITR.ZS

> References are candidate documentation for definitions and retrieval. Because the SQL seed rows are synthetic and the retrieval script has not been integrated into the database, do not claim these sources supplied the inserted values. Cite only sources actually consulted for the final data and claims.
