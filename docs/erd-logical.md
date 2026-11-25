# Proposed ER diagram (logical)

This diagram reflects the intended schema after importing the original World database and running `sql/01_additional_tables.sql`. Verify against the actual MySQL schema before submission.

```mermaid
erDiagram
    COUNTRY ||--o{ CITY : contains
    COUNTRY ||--o{ COUNTRY_LANGUAGE : "has language records"
    COUNTRY ||--o{ ECONOMIC_INDICATOR : "annual measures"
    COUNTRY ||--o{ HEALTH_INDICATOR : "annual measures"
    COUNTRY ||--o{ EDUCATION_INDICATOR : "annual measures"

    COUNTRY {
        char Code PK
        varchar Name
        varchar Continent
        varchar Region
        int Population
        decimal LifeExpectancy
        decimal GNP
        int Capital
    }
    CITY {
        int ID PK
        varchar Name
        char CountryCode FK
        varchar District
        int Population
    }
    COUNTRY_LANGUAGE {
        char CountryCode PK,FK
        varchar Language PK
        char IsOfficial
        decimal Percentage
    }
    ECONOMIC_INDICATOR {
        char CountryCode PK,FK
        smallint IndicatorYear PK
        decimal GDPPerCapitaUSD
        decimal UnemploymentRatePct
        decimal PovertyRatePct
    }
    HEALTH_INDICATOR {
        char CountryCode PK,FK
        smallint IndicatorYear PK
        decimal HealthExpenditurePctGDP
        decimal PhysiciansPer1000
        decimal MaternalMortalityPer100k
    }
    EDUCATION_INDICATOR {
        char CountryCode PK,FK
        smallint IndicatorYear PK
        decimal LiteracyRatePct
        decimal EducationExpenditurePctGDP
        decimal TertiaryEnrollmentPct
    }
```

Note: The supplied base schema may not declare the City and CountryLanguage foreign keys in DDL. The lines above depict their conceptual relationship; added indicator-table FKs are declared by the extension script.
