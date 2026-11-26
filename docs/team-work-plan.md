# Team work plan and handoff

## Current starter branch

Branch: `team-starter-work`

This branch adds a project README, three country-level indicator tables with illustrative sample rows, 20 draft SQL investigations (10 JOIN-based and 10 subquery-based), design notes, and this team checklist. The original base SQL and diagram files are preserved.

## Suggested division of work (four team members)

| Workstream | Suggested owner | Tasks |
|---|---|---|
| Schema and ERD | Troy Chin | Run scripts, verify keys/constraints, update editable Workbench ERD and physical model |
| Data and sources | Dominik Pelikan | Replace or supplement illustrative values with traceable UN/World Bank sources; record source, year, units, URL |
| Query testing | Mohit Sharma | Execute Q01–Q20, capture row counts, improve originality, explain results and limitations |
| Report and presentation | Armin Tehrani | Assemble APA report, references, slides, demo sequence, and coordinate review |

All members should review the complete project and contribute to the report/demo. Reassign work based on availability; this table is a starting point, not a substitute for the course's peer-contribution process.

## Execution order

1. Create the base `world` database with `world-mysql-creation-file.sql`.
2. Run `sql/01_additional_tables.sql`.
3. Confirm each added table has 16 sample rows:
   `SELECT COUNT(*) FROM EconomicIndicator;`
   `SELECT COUNT(*) FROM HealthIndicator;`
   `SELECT COUNT(*) FROM EducationIndicator;`
4. Run every query in `sql/02_investigation_queries.sql` individually.
5. Record query number, purpose, row count, and a brief interpretation. The course requires at least four rows per query.
6. Update and export the ER diagram and physical relational model.
7. Draft the report in Word using APA formatting: 12-point Times New Roman, double spacing, at least four pages excluding title and references.
8. Prepare a 10–15 minute presentation and a repeatable live demo.
9. Have a teammate run the full setup from a clean database before submission.

## Query validation log

Fill this table after executing the SQL on the team's MySQL instance.

| Query | Type | Rows returned (target >= 4) | Tested by | Notes |
|---|---|---:|---|---|
| Q01–Q10 | JOIN | Pending | | |
| Q11–Q20 | Subquery | Pending | | |

## Data provenance warning

The inserted indicator values are synthetic teaching data. Do not cite them as official statistics or draw real-world policy conclusions from them. For a defensible final analysis, replace them with sourced observations and preserve source name, URL, observation year, units, and access date in project documentation or a source-metadata table.

## Final acceptance checklist

- [ ] Original `City`, `Country`, and `CountryLanguage` tables retained.
- [ ] At least three meaningful additional tables present.
- [ ] Primary keys, foreign keys, relationships, and integrity constraints visible in ERD and physical model.
- [ ] All 20 SQL queries execute successfully.
- [ ] At least 10 queries use joins and at least 10 use subqueries.
- [ ] Every query returns at least four rows on the final dataset.
- [ ] Query purpose, output, and value explained in the report.
- [ ] APA-style Word report meets length and formatting requirements.
- [ ] Presentation is 10–15 minutes and all team members are ready.
- [ ] Final SQL, report, presentation, and demo submitted through Canvas by the course deadline.
