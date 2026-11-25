# Report outline and writing guide (team-authored final)

Use this outline to build the required APA-style Word report. Add your team's actual decisions, tested SQL, output screenshots/tables, interpretation, and sources. Do not treat placeholder sample values as official statistics.

## Title page
Project/team name, CPSC 332, date, all team members.

## 1. Introduction
Describe the World teaching database (Country, City, CountryLanguage) and the questions the team investigates. Explain why country-level economic, health, and education measures are relevant. Cite authoritative sources and define the scope.

## 2. Database development process
- ERD and reasoning for entities and relationships.
- Schema/data dictionary, primary keys, foreign keys, constraints.
- Logical and physical models.
- Explain the added country-year grain and why each domain is separated.
- Discuss limitations: base World data is historical; indicator sample is synthetic and not necessarily aligned to the same year.

## 3. Database investigation
Include Q01-Q20 using executable production SQL. For each query: question/purpose, SQL, tested row count, a table or screenshot of results, interpretation limited to what the data supports, and caveat where relevant. Explicitly identify Q01-Q10 as JOIN group and Q11-Q20 as subquery group, while noting queries may also contain joins.

## 4. Summary
Summarize patterns actually observed, lessons learned, data limitations, and possible improvements. Do not infer causation from exploratory comparisons.

## References
APA-formatted references for dataset pages and any other sources actually used.

## Formatting checklist
- [ ] Word (.docx)
- [ ] APA style
- [ ] 12-point Times New Roman
- [ ] Double spacing
- [ ] At least 4 pages of body text, excluding title and reference pages
- [ ] All 20 query explanations and results included
