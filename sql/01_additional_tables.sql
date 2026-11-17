-- CPSC 332 project extension
-- Run AFTER world-mysql-creation-file.sql.
-- MySQL 8.0.16+ is recommended so CHECK constraints are enforced.
-- These values are illustrative teaching data, NOT official UN/World Bank statistics.
USE world;

CREATE TABLE IF NOT EXISTS EconomicIndicator (
    CountryCode CHAR(3) NOT NULL,
    IndicatorYear SMALLINT NOT NULL,
    GDPPerCapitaUSD DECIMAL(12,2) NOT NULL,
    UnemploymentRatePct DECIMAL(5,2) NOT NULL,
    PovertyRatePct DECIMAL(5,2) NOT NULL,
    DataNote VARCHAR(120) NOT NULL DEFAULT 'Illustrative project sample',
    PRIMARY KEY (CountryCode, IndicatorYear),
    CONSTRAINT fk_economic_country
        FOREIGN KEY (CountryCode) REFERENCES Country(Code)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_econ_year CHECK (IndicatorYear BETWEEN 1900 AND 2100),
    CONSTRAINT chk_gdp_per_capita CHECK (GDPPerCapitaUSD >= 0),
    CONSTRAINT chk_unemployment CHECK (UnemploymentRatePct BETWEEN 0 AND 100),
    CONSTRAINT chk_poverty CHECK (PovertyRatePct BETWEEN 0 AND 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS HealthIndicator (
    CountryCode CHAR(3) NOT NULL,
    IndicatorYear SMALLINT NOT NULL,
    HealthExpenditurePctGDP DECIMAL(5,2) NOT NULL,
    PhysiciansPer1000 DECIMAL(6,2) NOT NULL,
    MaternalMortalityPer100k DECIMAL(8,2) NOT NULL,
    DataNote VARCHAR(120) NOT NULL DEFAULT 'Illustrative project sample',
    PRIMARY KEY (CountryCode, IndicatorYear),
    CONSTRAINT fk_health_country
        FOREIGN KEY (CountryCode) REFERENCES Country(Code)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_health_year CHECK (IndicatorYear BETWEEN 1900 AND 2100),
    CONSTRAINT chk_health_spending CHECK (HealthExpenditurePctGDP BETWEEN 0 AND 100),
    CONSTRAINT chk_physicians CHECK (PhysiciansPer1000 >= 0),
    CONSTRAINT chk_maternal_mortality CHECK (MaternalMortalityPer100k >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS EducationIndicator (
    CountryCode CHAR(3) NOT NULL,
    IndicatorYear SMALLINT NOT NULL,
    LiteracyRatePct DECIMAL(5,2) NOT NULL,
    EducationExpenditurePctGDP DECIMAL(5,2) NOT NULL,
    TertiaryEnrollmentPct DECIMAL(6,2) NOT NULL,
    DataNote VARCHAR(120) NOT NULL DEFAULT 'Illustrative project sample',
    PRIMARY KEY (CountryCode, IndicatorYear),
    CONSTRAINT fk_education_country
        FOREIGN KEY (CountryCode) REFERENCES Country(Code)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_education_year CHECK (IndicatorYear BETWEEN 1900 AND 2100),
    CONSTRAINT chk_literacy CHECK (LiteracyRatePct BETWEEN 0 AND 100),
    CONSTRAINT chk_education_spending CHECK (EducationExpenditurePctGDP BETWEEN 0 AND 100),
    CONSTRAINT chk_tertiary_enrollment CHECK (TertiaryEnrollmentPct BETWEEN 0 AND 200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- One illustrative 2023 observation per country. Replace with sourced observations
-- (and update DataNote) before making real-world claims in the report.
INSERT INTO EconomicIndicator
(CountryCode, IndicatorYear, GDPPerCapitaUSD, UnemploymentRatePct, PovertyRatePct)
VALUES
('AFG',2023,360.00,14.00,54.00),
('ARG',2023,13650.00,6.20,39.20),
('AUS',2023,64700.00,3.70,12.00),
('BRA',2023,10300.00,7.80,21.00),
('CAN',2023,53300.00,5.40,8.90),
('CHN',2023,12600.00,5.20,16.00),
('DEU',2023,52700.00,3.00,14.80),
('EGY',2023,3500.00,7.00,29.70),
('FRA',2023,44400.00,7.30,14.00),
('GBR',2023,48900.00,4.20,18.60),
('IND',2023,2500.00,7.80,21.90),
('JPN',2023,33800.00,2.60,15.70),
('MEX',2023,13900.00,2.80,36.30),
('NLD',2023,62500.00,3.60,7.40),
('USA',2023,82700.00,3.60,11.50),
('ZAF',2023,6800.00,32.10,55.50);

INSERT INTO HealthIndicator
(CountryCode, IndicatorYear, HealthExpenditurePctGDP, PhysiciansPer1000, MaternalMortalityPer100k)
VALUES
('AFG',2023,5.00,0.30,620.00),
('ARG',2023,9.50,4.00,45.00),
('AUS',2023,10.80,4.10,3.00),
('BRA',2023,9.60,2.60,60.00),
('CAN',2023,11.20,2.80,11.00),
('CHN',2023,5.40,2.40,23.00),
('DEU',2023,12.70,4.50,4.00),
('EGY',2023,4.80,0.80,17.00),
('FRA',2023,12.30,3.20,8.00),
('GBR',2023,11.10,3.20,10.00),
('IND',2023,3.30,0.90,97.00),
('JPN',2023,11.50,2.60,4.00),
('MEX',2023,5.50,2.50,33.00),
('NLD',2023,10.20,3.80,5.00),
('USA',2023,16.60,2.70,21.00),
('ZAF',2023,8.30,0.80,127.00);

INSERT INTO EducationIndicator
(CountryCode, IndicatorYear, LiteracyRatePct, EducationExpenditurePctGDP, TertiaryEnrollmentPct)
VALUES
('AFG',2023,37.30,3.20,10.00),
('ARG',2023,99.00,5.00,91.00),
('AUS',2023,99.00,5.30,113.00),
('BRA',2023,94.70,6.00,55.00),
('CAN',2023,99.00,5.20,78.00),
('CHN',2023,97.00,4.00,65.00),
('DEU',2023,99.00,4.50,72.00),
('EGY',2023,74.50,3.80,39.00),
('FRA',2023,99.00,5.40,70.00),
('GBR',2023,99.00,5.50,86.00),
('IND',2023,77.70,4.10,29.00),
('JPN',2023,99.00,3.40,64.00),
('MEX',2023,95.40,4.60,43.00),
('NLD',2023,99.00,5.20,85.00),
('USA',2023,99.00,5.00,88.00),
('ZAF',2023,95.00,6.60,25.00);
