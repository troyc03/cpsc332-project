#!/usr/bin/env python3
"""Fetch traceable World Bank indicator observations for the project's country sample.

Outputs data/worldbank_observations.csv with country ISO3, indicator code/name,
year, value, units, source URL and retrieval date. Does not overwrite SQL tables.
"""
import csv
import json
import time
from datetime import date
from pathlib import Path
from urllib.parse import quote
from urllib.request import Request, urlopen

COUNTRIES = ["AFG", "ARG", "AUS", "BRA", "CAN", "CHN", "DEU", "EGY", "FRA", "GBR", "IND", "JPN", "MEX", "NLD", "USA", "ZAF"]
INDICATORS = {
    "NY.GDP.PCAP.CD": "GDP per capita, current US$",
    "SL.UEM.TOTL.ZS": "Unemployment, total (% of labor force)",
    "SI.POV.DDAY": "Poverty headcount ratio at $2.15/day (2017 PPP)",
    "SH.XPD.CHEX.GD.ZS": "Current health expenditure (% of GDP)",
    "SH.MED.PHYS.ZS": "Physicians (per 1,000 people)",
    "SH.STA.MMRT": "Maternal mortality ratio (modeled, per 100,000 live births)",
    "SE.ADT.LITR.ZS": "Literacy rate, adult total (%)",
    "SE.XPD.TOTL.GD.ZS": "Government expenditure on education (% of GDP)",
    "SE.TER.ENRR": "School enrollment, tertiary (% gross)",
}
START_YEAR, END_YEAR = 2019, 2023
OUT = Path(__file__).resolve().parents[1] / "data" / "worldbank_observations.csv"

def fetch_indicator(code):
    countries = ";".join(COUNTRIES)
    url = f"https://api.worldbank.org/v2/country/{countries}/indicator/{quote(code)}?date={START_YEAR}:{END_YEAR}&format=json&per_page=20000"
    request = Request(url, headers={"User-Agent": "CPSC332-project-data-fetch/1.0"})
    with urlopen(request, timeout=45) as response:
        payload = json.load(response)
    if not isinstance(payload, list) or len(payload) < 2 or payload[1] is None:
        return url, []
    rows = []
    for item in payload[1]:
        value = item.get("value")
        if value is None:
            continue
        rows.append({
            "country_iso3": item["countryiso3code"],
            "country_name": item["country"]["value"],
            "indicator_code": code,
            "indicator_name": INDICATORS[code],
            "year": int(item["date"]),
            "value": value,
            "unit": item.get("unit") or "See indicator definition",
            "source_url": url,
            "retrieved_on": date.today().isoformat(),
        })
    return url, rows

def main():
    records = []
    for code in INDICATORS:
        url, rows = fetch_indicator(code)
        records.extend(rows)
        print(f"{code}: {len(rows)} observations | {url}")
        time.sleep(0.15)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fields = ["country_iso3", "country_name", "indicator_code", "indicator_name", "year", "value", "unit", "source_url", "retrieved_on"]
    with OUT.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        writer.writerows(records)
    print(f"Wrote {len(records)} rows to {OUT}")

if __name__ == "__main__":
    main()
