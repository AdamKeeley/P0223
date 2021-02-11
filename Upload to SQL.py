# -*- coding: utf-8 -*-
"""
Created on Mon Feb  1 11:24:42 2021

@author: uitake
"""

# Database Tables must already exist.

import pandas as pd
from sqlalchemy import create_engine
import urllib

file = (r'N:/Faculty-of-Medicine-and-Health/LIRMM/Molecular Rheumatology/GCA Molecular data/UK BioBank AID GC toxicity/UKBioBank/Data/Covid-19/covid19_tpp_gp_clinical.txt')
sql_server = 'IRC-PC010'
sql_database = 'P0223'
sql_schema = 'dbo'
sql_table = 'covid19_tpp_gp_clinical'
chunksize = 1000000

for chunk in pd.read_csv(file, sep='\t', chunksize=chunksize):
    conn = urllib.parse.quote_plus("DRIVER={SQL Server Native Client 11.0};SERVER=" + sql_server + ";DATABASE=" + sql_database + ";Trusted_Connection=yes")
    df = pd.DataFrame(chunk)
    df.rename(columns=df.iloc[0])
    df.event_dt = pd.to_datetime(df.event_dt, utc = True)
    engine = create_engine("mssql+pyodbc:///?odbc_connect=%s" % conn, fast_executemany=True)
    df.to_sql(sql_table, con = engine, if_exists = "append", schema = sql_schema, index = False)
df = df.iloc[0:0]
chunk = chunk.iloc[0:0]
