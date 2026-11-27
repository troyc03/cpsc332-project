# SQL Appendix: 20 Investigation Queries

This appendix mirrors the executable SQL in `sql/02_investigation_queries.sql`. Use the file as the source of truth if any future edits diverge. Run the seed schema and extension first. These are not locally validated yet; record real row counts and revise queries if any fail the four-row minimum.

```sql
-- CPSC 332 investigation queries
-- Run after world-mysql-creation-file.sql and sql/01_additional_tables.sql.
-- MySQL 8.0+. The 20 queries are starter drafts; validate row counts locally.
-- Queries 1-10 use JOINs. Queries 11-20 use subqueries.
-- Every query combines at least one original World table with an added indicator table.

USE world;

-- ============================================================
-- JOIN-BASED INVESTIGATIONS (1-10)
-- ============================================================

-- Q01. Compare economic, health, and education indicators by country.
-- Purpose: establish a multi-dimensional country profile.
SELECT c.Name, c.Continent, e.GDPPerCapitaUSD, h.HealthExpenditurePctGDP,
       d.LiteracyRatePct, d.TertiaryEnrollmentPct
FROM Country AS c
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code
JOIN HealthIndicator AS h ON h.CountryCode = c.Code AND h.IndicatorYear = e.IndicatorYear
JOIN EducationIndicator AS d ON d.CountryCode = c.Code AND d.IndicatorYear = e.IndicatorYear
WHERE e.IndicatorYear = 2023
ORDER BY e.GDPPerCapitaUSD DESC;

-- Q02. Relate country population and GDP per capita to its recorded cities.
-- Purpose: compare national scale with the size of the largest city.
SELECT c.Name, c.Population AS CountryPopulation, e.GDPPerCapitaUSD,
       COUNT(ci.ID) AS ListedCities, MAX(ci.Population) AS LargestCityPopulation
FROM Country AS c
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code
JOIN City AS ci ON ci.CountryCode = c.Code
WHERE e.IndicatorYear = 2023
GROUP BY c.Code, c.Name, c.Population, e.GDPPerCapitaUSD
ORDER BY LargestCityPopulation DESC;

-- Q03. Compare official-language reach with literacy and education investment.
-- Purpose: explore whether broad official-language coverage coexists with literacy.
SELECT c.Name, cl.Language, cl.Percentage AS LanguageSharePct,
       d.LiteracyRatePct, d.EducationExpenditurePctGDP
FROM Country AS c
JOIN CountryLanguage AS cl ON cl.CountryCode = c.Code AND cl.IsOfficial = 'T'
JOIN EducationIndicator AS d ON d.CountryCode = c.Code AND d.IndicatorYear = 2023
ORDER BY d.LiteracyRatePct DESC, cl.Percentage DESC;

-- Q04. Compare health spending and physician availability across continents.
-- Purpose: identify differences in health-system resources.
SELECT c.Continent, c.Name, h.HealthExpenditurePctGDP,
       h.PhysiciansPer1000, h.MaternalMortalityPer100k
FROM Country AS c
JOIN HealthIndicator AS h ON h.CountryCode = c.Code
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code AND e.IndicatorYear = h.IndicatorYear
WHERE h.IndicatorYear = 2023
ORDER BY c.Continent, h.PhysiciansPer1000 DESC;

-- Q05. Compare city populations with national health resources.
-- Purpose: inspect how large urban centers sit alongside national health indicators.
SELECT c.Name AS Country, ci.Name AS City, ci.District, ci.Population AS CityPopulation,
       h.PhysiciansPer1000, h.HealthExpenditurePctGDP
FROM Country AS c
JOIN City AS ci ON ci.CountryCode = c.Code
JOIN HealthIndicator AS h ON h.CountryCode = c.Code AND h.IndicatorYear = 2023
WHERE ci.Population IS NOT NULL
ORDER BY ci.Population DESC
LIMIT 30;

-- Q06. Compare city population with national income and poverty.
-- Purpose: locate large cities in countries with differing economic conditions.
SELECT c.Name AS Country, ci.Name AS City, ci.Population AS CityPopulation,
       e.GDPPerCapitaUSD, e.PovertyRatePct
FROM Country AS c
JOIN City AS ci ON ci.CountryCode = c.Code
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code AND e.IndicatorYear = 2023
ORDER BY ci.Population DESC
LIMIT 30;

-- Q07. Examine whether education spending aligns with tertiary enrollment.
-- Purpose: compare two education-system indicators for each country.
SELECT c.Name, c.Region, d.EducationExpenditurePctGDP,
       d.TertiaryEnrollmentPct, d.LiteracyRatePct, e.GDPPerCapitaUSD
FROM Country AS c
JOIN EducationIndicator AS d ON d.CountryCode = c.Code
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code AND e.IndicatorYear = d.IndicatorYear
WHERE d.IndicatorYear = 2023
ORDER BY d.TertiaryEnrollmentPct DESC;

-- Q08. Compare official-language population shares with poverty.
-- Purpose: provide a country context for language demographics and poverty.
SELECT c.Name, cl.Language, cl.Percentage AS LanguageSharePct,
       e.PovertyRatePct, e.GDPPerCapitaUSD
FROM Country AS c
JOIN CountryLanguage AS cl ON cl.CountryCode = c.Code
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code AND e.IndicatorYear = 2023
WHERE cl.IsOfficial = 'T'
ORDER BY e.PovertyRatePct DESC, cl.Percentage DESC;

-- Q09. Compare national population and city coverage with education outcomes.
-- Purpose: show the relationship between country scale, listed cities, and literacy.
SELECT c.Name, c.Population, COUNT(DISTINCT ci.ID) AS ListedCityCount,
       AVG(ci.Population) AS MeanListedCityPopulation,
       d.LiteracyRatePct, d.TertiaryEnrollmentPct
FROM Country AS c
JOIN City AS ci ON ci.CountryCode = c.Code
JOIN EducationIndicator AS d ON d.CountryCode = c.Code AND d.IndicatorYear = 2023
GROUP BY c.Code, c.Name, c.Population, d.LiteracyRatePct, d.TertiaryEnrollmentPct
ORDER BY d.LiteracyRatePct DESC;

-- Q10. Combine language, urban, health, and economic data.
-- Purpose: create a richer country comparison for policy discussion.
SELECT c.Name, c.Continent, cl.Language, cl.Percentage AS LanguageSharePct,
       COUNT(DISTINCT ci.ID) AS ListedCityCount,
       h.PhysiciansPer1000, e.GDPPerCapitaUSD
FROM Country AS c
JOIN CountryLanguage AS cl ON cl.CountryCode = c.Code AND cl.IsOfficial = 'T'
JOIN City AS ci ON ci.CountryCode = c.Code
JOIN HealthIndicator AS h ON h.CountryCode = c.Code AND h.IndicatorYear = 2023
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code AND e.IndicatorYear = h.IndicatorYear
GROUP BY c.Code, c.Name, c.Continent, cl.Language, cl.Percentage,
         h.PhysiciansPer1000, e.GDPPerCapitaUSD
ORDER BY e.GDPPerCapitaUSD DESC;

-- ============================================================
-- SUBQUERY-BASED INVESTIGATIONS (11-20)
-- ============================================================

-- Q11. Countries with GDP per capita above the sample average.
-- Purpose: compare health resources among above-average-income countries.
SELECT c.Name, c.Continent, e.GDPPerCapitaUSD, h.PhysiciansPer1000
FROM Country AS c
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code
JOIN HealthIndicator AS h ON h.CountryCode = c.Code AND h.IndicatorYear = e.IndicatorYear
WHERE e.IndicatorYear = 2023
  AND e.GDPPerCapitaUSD > (
      SELECT AVG(e2.GDPPerCapitaUSD)
      FROM EconomicIndicator AS e2
      WHERE e2.IndicatorYear = 2023
  )
ORDER BY e.GDPPerCapitaUSD DESC;

-- Q12. Countries with literacy above the sample average.
-- Purpose: identify above-average literacy countries and inspect spending/language records.
SELECT c.Name, d.LiteracyRatePct, d.EducationExpenditurePctGDP,
       cl.Language, cl.IsOfficial
FROM Country AS c
JOIN EducationIndicator AS d ON d.CountryCode = c.Code
JOIN CountryLanguage AS cl ON cl.CountryCode = c.Code
WHERE d.IndicatorYear = 2023
  AND d.LiteracyRatePct > (
      SELECT AVG(d2.LiteracyRatePct)
      FROM EducationIndicator AS d2
      WHERE d2.IndicatorYear = 2023
  )
ORDER BY d.LiteracyRatePct DESC;

-- Q13. Countries with poverty above the sample average and at least one listed city.
-- Purpose: connect poverty levels to national population and city records.
SELECT c.Name, c.Population, e.PovertyRatePct, e.GDPPerCapitaUSD
FROM Country AS c
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code
WHERE e.IndicatorYear = 2023
  AND e.PovertyRatePct > (
      SELECT AVG(e2.PovertyRatePct)
      FROM EconomicIndicator AS e2
      WHERE e2.IndicatorYear = 2023
  )
  AND EXISTS (
      SELECT 1 FROM City AS ci
      WHERE ci.CountryCode = c.Code
  )
ORDER BY e.PovertyRatePct DESC;

-- Q14. Countries with a matching health observation and at least one city.
-- Purpose: compare health-system resources for countries represented in City.
SELECT c.Name, h.HealthExpenditurePctGDP, h.PhysiciansPer1000,
       e.GDPPerCapitaUSD
FROM Country AS c
JOIN HealthIndicator AS h ON h.CountryCode = c.Code
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code AND e.IndicatorYear = h.IndicatorYear
WHERE h.IndicatorYear = 2023
  AND c.Code IN (
      SELECT ci.CountryCode
      FROM City AS ci
      WHERE ci.Population > 0
      GROUP BY ci.CountryCode
  )
ORDER BY h.PhysiciansPer1000 DESC;

-- Q15. Countries with GDP per capita above the sample mean.
-- Purpose: compare education indicators among above-average-income countries.
SELECT c.Name, e.GDPPerCapitaUSD, d.LiteracyRatePct, d.TertiaryEnrollmentPct
FROM Country AS c
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code
JOIN EducationIndicator AS d ON d.CountryCode = c.Code AND d.IndicatorYear = e.IndicatorYear
WHERE e.IndicatorYear = 2023
  AND e.GDPPerCapitaUSD > (
      SELECT AVG(e2.GDPPerCapitaUSD)
      FROM EconomicIndicator AS e2
      WHERE e2.IndicatorYear = 2023
  )
ORDER BY d.TertiaryEnrollmentPct DESC;

-- Q16. Official-language records with a share above that country's official-language average.
-- Purpose: identify relatively widely spoken official languages within each country.
SELECT c.Name, cl.Language, cl.Percentage, h.PhysiciansPer1000,
       d.LiteracyRatePct
FROM Country AS c
JOIN CountryLanguage AS cl ON cl.CountryCode = c.Code
JOIN HealthIndicator AS h ON h.CountryCode = c.Code AND h.IndicatorYear = 2023
JOIN EducationIndicator AS d ON d.CountryCode = c.Code AND d.IndicatorYear = h.IndicatorYear
WHERE cl.IsOfficial = 'T'
  AND cl.Percentage > (
      SELECT AVG(cl2.Percentage)
      FROM CountryLanguage AS cl2
      WHERE cl2.CountryCode = c.Code
        AND cl2.IsOfficial = 'T'
  )
ORDER BY cl.Percentage DESC;

-- Q17. Countries with population above the World-table sample average.
-- Purpose: compare population scale with health spending and physician density.
SELECT c.Name, c.Population, h.HealthExpenditurePctGDP,
       h.PhysiciansPer1000, e.PovertyRatePct
FROM Country AS c
JOIN HealthIndicator AS h ON h.CountryCode = c.Code
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code AND e.IndicatorYear = h.IndicatorYear
WHERE h.IndicatorYear = 2023
  AND c.Population > (
      SELECT AVG(c2.Population)
      FROM Country AS c2
      WHERE c2.Population IS NOT NULL
  )
ORDER BY c.Population DESC;

-- Q18. Countries whose listed-city population total is positive.
-- Purpose: compare education outcomes for countries with recorded urban populations.
SELECT c.Name, d.LiteracyRatePct, d.TertiaryEnrollmentPct,
       e.GDPPerCapitaUSD
FROM Country AS c
JOIN EducationIndicator AS d ON d.CountryCode = c.Code
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code AND e.IndicatorYear = d.IndicatorYear
WHERE d.IndicatorYear = 2023
  AND (
      SELECT SUM(ci.Population)
      FROM City AS ci
      WHERE ci.CountryCode = c.Code
  ) > 0
ORDER BY d.LiteracyRatePct DESC;

-- Q19. Countries with education spending above the sample average.
-- Purpose: compare above-average education investment with poverty and population.
SELECT c.Name, c.Population, d.EducationExpenditurePctGDP,
       d.LiteracyRatePct, e.PovertyRatePct
FROM Country AS c
JOIN EducationIndicator AS d ON d.CountryCode = c.Code
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code AND e.IndicatorYear = d.IndicatorYear
WHERE d.IndicatorYear = 2023
  AND d.EducationExpenditurePctGDP > (
      SELECT AVG(d2.EducationExpenditurePctGDP)
      FROM EducationIndicator AS d2
      WHERE d2.IndicatorYear = 2023
  )
ORDER BY d.EducationExpenditurePctGDP DESC;

-- Q20. Countries with at least one official-language record and a health observation.
-- Purpose: summarize language, health, and income information for the sample.
SELECT c.Name, c.Continent, h.MaternalMortalityPer100k,
       h.HealthExpenditurePctGDP, e.GDPPerCapitaUSD
FROM Country AS c
JOIN HealthIndicator AS h ON h.CountryCode = c.Code
JOIN EconomicIndicator AS e ON e.CountryCode = c.Code AND e.IndicatorYear = h.IndicatorYear
WHERE h.IndicatorYear = 2023
  AND EXISTS (
      SELECT 1
      FROM CountryLanguage AS cl
      WHERE cl.CountryCode = c.Code
        AND cl.IsOfficial = 'T'
  )
ORDER BY h.MaternalMortalityPer100k DESC;
```
