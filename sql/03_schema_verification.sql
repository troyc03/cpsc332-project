-- Schema integrity checks for the project extension.
-- Run after importing the World schema and executing sql/01_additional_tables.sql.
USE world;

-- 1. Inspect table definitions, including PK/FK/constraint metadata.
SHOW CREATE TABLE EconomicIndicator;
SHOW CREATE TABLE HealthIndicator;
SHOW CREATE TABLE EducationIndicator;

-- 2. Confirm primary-key columns are CountryCode + IndicatorYear.
SELECT TABLE_NAME, COLUMN_NAME, ORDINAL_POSITION
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME IN ('EconomicIndicator','HealthIndicator','EducationIndicator')
  AND CONSTRAINT_NAME = 'PRIMARY'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

-- 3. Confirm each CountryCode foreign key points to Country.Code.
SELECT TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME,
       CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME IN ('EconomicIndicator','HealthIndicator','EducationIndicator')
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;

-- 4. Confirm extension table sample counts and duplicate keys (duplicate results should be empty).
SELECT 'EconomicIndicator' AS TableName, COUNT(*) AS RowCount FROM EconomicIndicator
UNION ALL
SELECT 'HealthIndicator', COUNT(*) FROM HealthIndicator
UNION ALL
SELECT 'EducationIndicator', COUNT(*) FROM EducationIndicator;

SELECT CountryCode, IndicatorYear, COUNT(*) AS DuplicateCount
FROM EconomicIndicator GROUP BY CountryCode, IndicatorYear HAVING COUNT(*) > 1;
SELECT CountryCode, IndicatorYear, COUNT(*) AS DuplicateCount
FROM HealthIndicator GROUP BY CountryCode, IndicatorYear HAVING COUNT(*) > 1;
SELECT CountryCode, IndicatorYear, COUNT(*) AS DuplicateCount
FROM EducationIndicator GROUP BY CountryCode, IndicatorYear HAVING COUNT(*) > 1;

-- 5. Verify country codes have no orphaned rows (each query should return zero).
SELECT e.CountryCode FROM EconomicIndicator e LEFT JOIN Country c ON c.Code=e.CountryCode WHERE c.Code IS NULL;
SELECT h.CountryCode FROM HealthIndicator h LEFT JOIN Country c ON c.Code=h.CountryCode WHERE c.Code IS NULL;
SELECT d.CountryCode FROM EducationIndicator d LEFT JOIN Country c ON c.Code=d.CountryCode WHERE c.Code IS NULL;
