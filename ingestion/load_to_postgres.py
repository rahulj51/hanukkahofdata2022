import os
import inflection as inflection
import psycopg2
import glob

print("Loading raw data...")
host = os.getenv("DB_HOST") or "db"
port = os.getenv("DB_PORT") or 5432
conn = psycopg2.connect(dbname="hanukkah", host=host, port=port, user="noah", password="secret")
conn.set_session(autocommit=True)
cur = conn.cursor()

# create schema
cur.execute("drop schema if exists raw cascade; create schema raw;");

# load tables
cwd = os.getcwd()
csvs = glob.glob(f'{cwd}/csv/*.csv')
#
for csv in csvs:
    basename = os.path.basename(csv)
    tname = os.path.splitext(basename)[0]
    sname, tname = tname.split('-')
    sname = sname.lower()
    tname = inflection.underscore(tname)

    with open(csv) as f:
        firstLine = f.readline().strip()
        columns = firstLine.split(",")

        # Build SQL code to drop table if exists and create table
        sqlQueryCreate = 'DROP TABLE IF EXISTS raw.' + sname + "_" + tname + ";\n"
        sqlQueryCreate += 'CREATE TABLE raw.' + sname + "_" + tname + "("

        # some loop or function according to your requiremennt
        # Define columns for table
        for column in columns:
            sqlQueryCreate += f"\"{column}\"" + " VARCHAR(64),\n"

        sqlQueryCreate = sqlQueryCreate[:-2]
        sqlQueryCreate += ");"
        # print(sqlQueryCreate)
        cur.execute(sqlQueryCreate)

        # copy data
        cur.copy_expert(f"COPY raw.{sname}_{tname}  from stdin delimiter ',' csv;", f)

print("Loaded raw data !!!")