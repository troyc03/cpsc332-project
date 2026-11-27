# Completion and submission status

Updated November 26, 2026.

## Completed in GitHub
- Base World schema preserved.
- Three additional indicator tables and illustrative sample rows are in `sql/01_additional_tables.sql`.
- 20 investigation SQL queries are in `sql/02_investigation_queries.sql`, with Q01–Q10 JOIN-oriented and Q11–Q20 subquery-oriented.
- Schema-verification SQL and World Bank observation retrieval script are included.
- Logical design, source documentation, report draft, presentation plan, and team checklist are documented.

## Still requires local database execution or team confirmation
- [ ] Import the original World database SQL into MySQL.
- [ ] Execute the additional tables script.
- [ ] Execute and inspect `sql/03_schema_verification.sql`.
- [ ] Run all 20 queries and confirm each returns at least 4 rows. Record real counts and fix any failures.
- [ ] Capture query outputs for the report and presentation.
- [ ] Update the editable MySQL Workbench model and export the final ER diagram and physical model.
- [ ] Confirm team name, member names, date, contributions, and presenter/demo laptop.
- [ ] Replace report/presentation placeholders with verified findings.
- [ ] Format the report in APA style in Word (12-point Times New Roman, double spaced, at least 4 pages of body text, excluding title/references).
- [ ] Prepare a 10–15 minute presentation and rehearse demo.
- [ ] Submit final report, PPT, SQL, and demo via Canvas by the assignment deadline (December 8, 2026).

## Validation integrity
The earlier Python row-count validator was removed from the repository and is not required to complete the SQL validation. Use MySQL Workbench directly if credential troubleshooting is inconvenient. This status document does not claim the SQL has been executed or row-count requirements have been met.
