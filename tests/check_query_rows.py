#!/usr/bin/env python3
"""Execute Q01-Q20 and report whether each query meets the assignment's 4-row minimum.

Prerequisites: import the World seed and run sql/01_additional_tables.sql.
Install dependency: pip install -r tests/requirements.txt
Connection settings are read from MYSQL_HOST, MYSQL_PORT, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE.
"""
import os
import re
import sys
import mysql.connector

SQL_PATH = os.path.join(os.path.dirname(__file__), "..", "sql", "02_investigation_queries.sql")
MIN_ROWS = 4

def load_queries(path):
    with open(path, encoding="utf-8") as f:
        sql = f.read()
    # Remove line comments and USE statements, then split at semicolon.
    sql = re.sub(r"(?m)^\s*--.*$", "", sql)
    sql = re.sub(r"(?im)^\s*USE\s+\w+\s*;\s*$", "", sql)
    chunks = [s.strip() for s in sql.split(";") if s.strip()]
    return [s for s in chunks if re.match(r"(?is)^SELECT\b", s)]

def main():
    queries = load_queries(os.path.abspath(SQL_PATH))
    if len(queries) != 20:
        print(f"ERROR: expected 20 SELECT statements; parsed {len(queries)}", file=sys.stderr)
        return 2
    cnx = mysql.connector.connect(
        host=os.getenv("MYSQL_HOST", "127.0.0.1"),
        port=int(os.getenv("MYSQL_PORT", "3306")),
        user=os.getenv("MYSQL_USER", "root"),
        password=os.getenv("MYSQL_PASSWORD", ""),
        database=os.getenv("MYSQL_DATABASE", "world"),
    )
    cursor = cnx.cursor()
    failed = False
    for i, query in enumerate(queries, 1):
        try:
            cursor.execute(query)
            rows = cursor.fetchall()
            count = len(rows)
            ok = count >= MIN_ROWS
            print(f"Q{i:02d}: {count} rows - {'PASS' if ok else 'FAIL (minimum 4 rows)'}")
            failed |= not ok
        except mysql.connector.Error as exc:
            print(f"Q{i:02d}: SQL ERROR - {exc}")
            failed = True
    cursor.close()
    cnx.close()
    print("\nOverall:", "FAIL" if failed else "PASS")
    return 1 if failed else 0

if __name__ == "__main__":
    raise SystemExit(main())
