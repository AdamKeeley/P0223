# -*- coding: utf-8 -*-
"""
Created on Mon Feb  1 11:24:42 2021

@author: uitake
"""

import pandas as pd
from sqlalchemy import create_engine
import urllib

path = (r'N:/Academic-Services/ISS/IRC-Data-Services/Projects/P0223 - Biobank Autoimmune Disease Covid-19/AK/')
file = r'coding7678.tsv'
sql_server = 'IRC-PC010'
sql_database = 'P0223'
sql_schema = 'tlk'
sql_table = 'EMIS_prescription_codes'
chunksize = 1000000
delimiter = '\t'

for chunk in pd.read_csv(path + file, sep=delimiter, chunksize=chunksize):
    conn = urllib.parse.quote_plus("DRIVER={SQL Server Native Client 11.0};SERVER=" + sql_server + ";DATABASE=" + sql_database + ";Trusted_Connection=yes")
    df = pd.DataFrame(chunk)
    df.rename(columns=df.iloc[0])
    
    #df.event_dt = pd.to_datetime(df.event_dt, utc = True)
    
    engine = create_engine("mssql+pyodbc:///?odbc_connect=%s" % conn, fast_executemany=True)
    df.to_sql(sql_table, con = engine, if_exists = "append", schema = sql_schema, index = False)
df = df.iloc[0:0]
chunk = chunk.iloc[0:0]
