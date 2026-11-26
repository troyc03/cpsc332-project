# World Bank data retrieval and provenance

The current extension inserts illustrative values. For traceable observations, use the downloader:

```bash
python3 scripts/fetch_worldbank_data.py
```

It writes `data/worldbank_observations.csv` and does not modify the database. Each record includes the country ISO3 code, indicator code and label, observation year, value, unit field, API URL, and retrieval date. The script requests 2019–2023 values for the 16 country sample. Missing observations are omitted, not fabricated or interpolated.

The API provides programmatic indicator data and JSON responses without requiring an API key. See World Bank API documentation:
- API V2 indicators overview: https://datahelpdesk.worldbank.org/knowledgebase/articles/889392
- Basic API query structure and date-range syntax: https://datahelpdesk.worldbank.org/knowledgebase/articles/898581

## Indicator mapping

| Project field | World Bank indicator | Units / definition |
|---|---|---|
| GDP per capita | NY.GDP.PCAP.CD | Current US dollars per person |
| Unemployment rate | SL.UEM.TOTL.ZS | Percent of labor force, modeled ILO estimate |
| Poverty rate | SI.POV.DDAY | Headcount at $2.15/day, 2017 PPP; not interchangeable with national poverty rates |
| Health expenditure | SH.XPD.CHEX.GD.ZS | Current health spending as % GDP |
| Physicians | SH.MED.PHYS.ZS | Physicians per 1,000 people |
| Maternal mortality | SH.STA.MMRT | Modeled deaths per 100,000 live births |
| Literacy | SE.ADT.LITR.ZS | Adult literacy rate, percent |
| Education expenditure | SE.XPD.TOTL.GD.ZS | Government expenditure on education as % GDP |
| Tertiary enrollment | SE.TER.ENRR | Gross tertiary enrollment, percent; can exceed 100% |

## Important integration note

This CSV is a source audit/extract, not a direct SQL loader. The extension tables have one year field per country-observation and the current investigation queries expect aligned years across indicator tables. Before replacing illustrative inserts, select a common observation year per country across the required indicators (or revise joins to handle indicator-specific years explicitly), and document missingness. Do not treat the values in the CSV as interchangeable with the current illustrative rows until the SQL mapping and year alignment have been reviewed. The downloaded CSV itself is reproducible evidence of source retrieval; use it to record actual chosen values and update the report with the exact years and units.
