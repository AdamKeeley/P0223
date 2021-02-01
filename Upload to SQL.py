# -*- coding: utf-8 -*-
"""
Created on Mon Feb  1 11:24:42 2021

@author: uitake
"""

# Database Tables must already exist.

import pandas as pd
from sqlalchemy import create_engine
import urllib

file = (r'N:/Faculty-of-Medicine-and-Health/LIRMM\Molecular Rheumatology/GCA Molecular data/UK BioBank AID GC toxicity/UKBioBank/Data/Covid-19/covid19_emis_gp_clinical.txt')
SQL_server = 'IRC-PC010'
SQL_database = 'P0223'
SQL_schema = 'dbo'
SQL_table = 'covid19_emis_gp_clinical'
chunksize = 100000

params = urllib.parse.quote_plus("DRIVER={SQL Server Native Client 11.0};SERVER=" + SQL_server + ";DATABASE=" + SQL_database + ";Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30")

for chunk in pd.read_csv(file, sep='\t', chunksize=chunksize):
	df = pd.DataFrame(chunk)
	df.rename(columns=df.iloc[0])
	df.event_dt = pd.to_datetime(df.event_dt, utc = True)
	engine = create_engine('mssql+pyodbc://' + SQL_server + '/' + SQL_database + '?driver=SQL Server Native Client 11.0')
	df.to_sql(SQL_table, con = engine, if_exists = "append", schema = SQL_schema, index = False)
