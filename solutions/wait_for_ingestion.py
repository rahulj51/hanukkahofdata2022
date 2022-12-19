import os
import time
import psycopg2

print("Waiting for raw data ingestion...")

host = os.getenv("DB_HOST") or "db"
port = os.getenv("DB_PORT") or 5432
conn = psycopg2.connect(dbname="hanukkah", host=host, port=port, user="noah", password="secret")
conn.set_session(autocommit=True)
cur = conn.cursor()

retries=0
while(True):
    cur.execute("select count(*) from information_schema.tables where table_schema = 'raw';")
    rec = cur.fetchone()
    count = rec[0]
    print(f"Count of ingested tables = {count}")
    if count >= 4 or retries > 5:
        break
    else:
        time.sleep(5)
        retries += 1
        print("Still waiting...")

if retries > 5:
    print("Waited enough. Ingestion seems to have failed.")
    exit(-1)
else:
    print("Ingestion completed.")
    exit(0)
