# -*- coding: utf-8 -*-
"""
Created on Mon Feb  1 11:24:42 2021

@author: uitake
"""

import pandas as pd
from sqlalchemy import create_engine
import urllib

path = (r'N:/Faculty-of-Medicine-and-Health/LIRMM/Molecular Rheumatology/GCA Molecular data/UK BioBank AID GC toxicity/UKBioBank/Data/Covid-19/')
file = r'covid19_tpp_gp_scripts.txt'
sql_server = 'IRC-PC010'
sql_database = 'P0223'
sql_schema = 'dbo'
sql_table = 'covid19_tpp_gp_scripts'
chunksize = 1000000
delimiter = '\t'

for chunk in pd.read_csv(path + file, sep=delimiter, chunksize=chunksize):
    conn = urllib.parse.quote_plus("DRIVER={SQL Server Native Client 11.0};SERVER=" + sql_server + ";DATABASE=" + sql_database + ";Trusted_Connection=yes")
    df = pd.DataFrame(chunk)
    df.rename(columns=df.iloc[0])
    
    df.issue_date = pd.to_datetime(df.issue_date, utc = True)
    
    engine = create_engine("mssql+pyodbc:///?odbc_connect=%s" % conn, fast_executemany=True)
    df.to_sql(sql_table, con = engine, if_exists = "append", schema = sql_schema, index = False)
df = df.iloc[0:0]
chunk = chunk.iloc[0:0]
