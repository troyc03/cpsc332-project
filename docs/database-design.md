# Database design notes

## Scope and assumptions

The supplied World database remains the foundation. Its original entities are `Country`, `City`, and `CountryLanguage`. The extension adds three country-year indicator entities so the team can compare economic, health, and education conditions with original demographic, urban, and language data.

The added 2023 observations are illustrative sample values for query development, not official measurements. Replace them with sourced values or clearly retain the synthetic-data limitation in the report and presentation.

## Logical model

| Entity | Primary key | Important attributes | Relationship |
|---|---|---|---|
| Country (base) | Code | Name, Continent, Region, Population, LifeExpectancy, GNP, Capital | Parent of child entities |
| City (base) | ID | Name, CountryCode, District, Population | Many cities belong to one country |
| CountryLanguage (base) | CountryCode + Language | IsOfficial, Percentage | Many language records belong to one country |
| EconomicIndicator (added) | CountryCode + IndicatorYear | GDPPerCapitaUSD, UnemploymentRatePct, PovertyRatePct | Many annual observations belong to one country |
| HealthIndicator (added) | CountryCode + IndicatorYear | HealthExpenditurePctGDP, PhysiciansPer1000, MaternalMortalityPer100k | Many annual observations belong to one country |
| EducationIndicator (added) | CountryCode + IndicatorYear | LiteracyRatePct, EducationExpenditurePctGDP, TertiaryEnrollmentPct | Many annual observations belong to one country |

## Relationships and constraints

- `Country.Code` is the parent key for `City.CountryCode` and `CountryLanguage.CountryCode` conceptually. The supplied creation script does not declare those foreign keys; consider adding them to the physical model to enforce referential integrity.
- Each added indicator table has composite primary key `(CountryCode, IndicatorYear)`, allowing one record per country per year.
- Each added `CountryCode` is a foreign key to `Country.Code`, with `ON UPDATE CASCADE` and `ON DELETE RESTRICT`.
- The extension constrains percentages to sensible ranges, nonnegative rates/counts, and indicator years to 1900–2100.
- `DECIMAL` is used for measured numeric indicators rather than approximate floating-point storage.

## ERD / physical-model update checklist

1. Open `eer_diagram.mwb` in MySQL Workbench.
2. Reverse-engineer or refresh the original `world` schema if needed.
3. Add `EconomicIndicator`, `HealthIndicator`, and `EducationIndicator` with columns and composite keys from `sql/01_additional_tables.sql`.
4. Draw one-to-many relationships from `Country.Code` to each added table's `CountryCode`.
5. Show composite primary keys, foreign keys, nullability, CHECK constraints, and year attribute.
6. Export a new PNG and retain the editable Workbench model. Keep the original diagram until the team reviews the updated one.

## Modeling decisions for the report

- Country-year is the grain for new data because development indicators change over time.
- The three indicator domains are separate entities to avoid one wide table with unrelated nullable columns.
- Composite keys prevent duplicate observations for the same country and year.
- Country-level indicators are joined to city and language data only for exploratory comparisons. They are not city- or language-level measurements.
- The classic World database is a historical teaching dataset. Its population, GNP, and life-expectancy values may not align temporally with the illustrative 2023 rows. Disclose this limitation and avoid causal claims.

## Validation still required

Run the base script, extension script, and query script in order on the team's MySQL version. Confirm foreign-key creation succeeds, inspect seeded country codes, and record the row count for each of the 20 queries. The assignment requires at least four rows per query. Revise predicates or data if any query returns fewer.
