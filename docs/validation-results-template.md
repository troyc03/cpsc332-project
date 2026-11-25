# SQL validation record

Do not mark a query validated until it has been run against the team's imported MySQL database. Add a date, MySQL version, operator, actual row count, and notes.

| Query | Rows returned | >= 4? | Error/fix notes | Tested by / date |
|---|---:|---|---|---|
| Q01 | | | | |
| Q02 | | | | |
| Q03 | | | | |
| Q04 | | | | |
| Q05 | | | | |
| Q06 | | | | |
| Q07 | | | | |
| Q08 | | | | |
| Q09 | | | | |
| Q10 | | | | |
| Q11 | | | | |
| Q12 | | | | |
| Q13 | | | | |
| Q14 | | | | |
| Q15 | | | | |
| Q16 | | | | |
| Q17 | | | | |
| Q18 | | | | |
| Q19 | | | | |
| Q20 | | | | |

## Environment
- MySQL version:
- Seed import date:
- Extension script run:
- Tester:

## Schema checks
- [ ] Three additional tables exist.
- [ ] Composite primary keys are present in each indicator table.
- [ ] Each indicator table has FK to Country(Code).
- [ ] Constraint behavior was checked (invalid values and orphan country code rejected).
- [ ] Seed rows are 16 per indicator table, unless team has intentionally changed the sample.
- [ ] ER diagram and physical model reflect the executed schema.

## Evidence
Attach screenshots or exported result tables for each query in the team's report or appendix. Keep this record factual: failed tests are useful evidence of fixes, not something to hide.
