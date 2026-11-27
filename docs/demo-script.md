# Live demo script (approximately 3 minutes)

## Before class
1. Open MySQL Workbench and connect to the database.
2. Confirm `world` is selected and the three extension tables exist.
3. Keep the SQL file `sql/02_investigation_queries.sql` open at Q01 and Q11.
4. Have verified screenshots ready as backup. Do not run unvalidated queries live without rehearsal.

## Demo narration
**Schema (30 seconds):** “The original World schema contains Country, City, and CountryLanguage. We added EconomicIndicator, HealthIndicator, and EducationIndicator. The indicator tables use a country-year composite key and a foreign key to Country.”

**JOIN example (about 60 seconds):** Run Q01 after it has been locally tested. Explain how Country links the three indicator domains for a combined country profile. Point out the columns and the actual result row count. State clearly that the current added sample values are illustrative, not official statistics.

**Subquery example (about 60 seconds):** Run Q11 after testing. Explain the inner query calculates the average GDP per capita for the sample year and the outer query filters countries above that threshold, while joining health data for physician density. Show the returned rows and count.

**Wrap-up (30 seconds):** “The project demonstrates how keys, constraints, joins, and subqueries support multi-table investigation. The results are descriptive, and the synthetic sample and time alignment limit real-world conclusions.”

## Demo contingency
If MySQL fails during presentation, show previously captured result screenshots and the SQL. Explain that the demo connection failed and do not pretend the screenshot was generated live.
