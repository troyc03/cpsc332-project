# Presentation plan and speaker notes (10–15 minutes)

Use a 10-slide deck. Target about 11–12 minutes plus a short live demo. All four members should participate. Replace pending result references with verified output; do not fabricate screenshots, row counts, or findings.

## Slide 1 — Title and scenario (0:45)
**On slide:** UN World Database Investigation; CPSC 332 Fall 2026; team members.  
**Speaker notes:** Explain the database-administrator scenario and project goal: investigate how relational tables support exploratory comparisons across countries.

## Slide 2 — Original World database (1:00)
**On slide:** Country, City, CountryLanguage; key attributes and the central Country entity.  
**Speaker notes:** Describe the supplied tables and their connections.

## Slide 3 — Investigation scope (1:00)
**On slide:** Economic, health, and education domains; sample country-year; questions about income, health resources, literacy, cities, and languages.  
**Speaker notes:** Explain why the additional domains were selected. Disclose that the current extension values are illustrative, not official measurements.

## Slide 4 — ER diagram (1:15)
**On slide:** Insert updated ER diagram with all six tables and relationships.  
**Speaker notes:** Explain Country as parent, one-to-many relationships, country-year grain, and composite keys. Pending updated Workbench model.

## Slide 5 — Physical model and integrity (1:15)
**On slide:** Insert updated physical model; show key types and constraints.  
**Speaker notes:** Explain CountryCode + IndicatorYear PK, CountryCode FK, CHECK constraints, data types, and separation of indicator domains.

## Slide 6 — Data sources and limitations (1:00)
**On slide:** Synthetic seed sample, sample size/year, retrieval tool, limitations.  
**Speaker notes:** Disclose synthetic values; explain the base World dataset's historical context and temporal mismatch. The retrieval script creates a provenance CSV only, not a DB loader.

## Slide 7 — JOIN investigations (1:15)
**On slide:** Q01 multi-domain profile and one additional JOIN query; verified output screenshot.  
**Speaker notes:** Describe the joins and comparisons they enable. Avoid causal claims.

## Slide 8 — Subquery investigations (1:15)
**On slide:** Q11 sample-average GDP comparison and one additional subquery; verified output screenshot.  
**Speaker notes:** Explain how subqueries define a benchmark or selection condition.

## Slide 9 — Findings and demo (1:30)
**On slide:** 2–3 output-supported findings; validation table; demo sequence.  
**Speaker notes:** Findings pending execution. Show schema and run one JOIN plus one subquery, explain actual outputs and row counts.

## Slide 10 — Conclusion and lessons (0:45)
**On slide:** Modeling, keys and constraints, query patterns, caveats, next steps.  
**Speaker notes:** Summarize what the database enables and what the sample cannot establish. Mention data grain and validation lessons.

## Demo checklist
- [ ] Confirm base World schema is loaded.
- [ ] Confirm added tables and sample rows exist.
- [ ] Run one JOIN query (suggest Q01).
- [ ] Run one subquery (suggest Q11).
- [ ] Explain actual returned rows and row counts.
- [ ] Do not show synthetic values as real statistics.
- [ ] Save result screenshots as backup.

## Presentation logistics
- Target 10–15 minutes, demo included.
- All team members attend and contribute.
- Designate a laptop for demo and rehearse before presentation.
- Course instructions specify Canvas submission; only the group leader submits final PPT, report, and SQL file.
