# CPSC 332 Project: UN World Database Investigation

This repository contains the team's starter materials for the Fall 2026 CPSC 332 database project. The project extends the supplied MySQL World database and investigates relationships among country demographics, economic conditions, health, and education.

## Repository contents

- `world-mysql-creation-file.sql`: supplied base World database. Run this first.
- `sql/01_additional_tables.sql`: adds three country-level indicator tables and sample data. Run second.
- `sql/02_investigation_queries.sql`: 20 draft investigation queries, split into 10 JOIN queries and 10 subquery queries. Run third.
- `docs/database-design.md`: proposed logical model, keys, relationships, and ER-diagram update notes.
- `docs/team-work-plan.md`: task breakdown, validation checklist, and handoff notes.
- `eer_diagram.mwb` and `eer_diagram.sql.png`: original diagram artifacts. They still need to be updated to include the three new tables.

## Setup

Tested design target: MySQL 8.0.16+ (the added schema uses enforced `CHECK` constraints).

1. Create/import the supplied base database by running `world-mysql-creation-file.sql`.
2. Run `sql/01_additional_tables.sql` in the same MySQL session or connection.
3. Run `sql/02_investigation_queries.sql` one query at a time and record the row count and a screenshot/export of each result.
4. Update the ER diagram and physical model to match the resulting schema.

The extension script expects the original `world.Country`, `world.City`, and `world.CountryLanguage` tables to exist. It does not replace or modify the supplied seed data.

## Important team checks

- The indicator values are clearly labeled illustrative/sample data, not verified UN or World Bank statistics. Replace or cite them before presenting findings as real-world facts.
- Confirm every query returns at least four rows on the team's actual MySQL installation. The queries are designed around the included sample rows, but the team must execute and document the results.
- Review query originality and adjust the wording/analysis to reflect your team's own investigation.
- Update the ER diagram and physical model; the existing diagram files are the original baseline, not the completed design.
- The assignment submission is through Canvas. GitHub is the team's collaboration workspace, not the final submission destination.

## Project requirements

The assignment calls for at least three additional tables, primary and foreign keys, relationships/integrity constraints, 20 innovative SQL queries (at least 10 using joins and at least 10 using subqueries), and a four-page-minimum APA-style report (excluding title and references) plus a 10–15 minute presentation. See the course instructions supplied to the team for the authoritative requirements and due date.
