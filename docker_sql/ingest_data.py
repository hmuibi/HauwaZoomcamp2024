#!/usr/bin/env python
# coding: utf-8

import os
import argparse

from time import time

import pandas as pd
import sqlalchemy
from sqlalchemy import create_engine

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url= params.url

    if url.endswith('.csv.gz'):
        csv_name = 'output.csv.gz'
    else:
        csv_name = 'output.csv'

    #download the csv
    os.system(f"wget {url} -O {csv_name}")

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    #engine = create_engine('postgresql://root:root@localhost:5432/ny_taxi')

    #engine.connect()
    #print(pd.io.sql.get_schema(df, name='yellow_taxi_data', con=engine))

    df_iter = pd.read_csv(csv_name, iterator=True, chunksize=100000, compression='gzip')
    df = next(df_iter)

    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    (df.tpep_dropoff_datetime) = pd.to_datetime(df.tpep_dropoff_datetime)

    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')


    df.to_sql(name=table_name, con=engine, if_exists='append')
    # The cell below is a while loop that will iterate through the entire file in 100000 chunks set in cell 51. using the t_stat, 
    # we want to measure how much time each iteration takes. We end up subtracting start from end to deduce how long it takes.  The %.3f means it will be treated as float and it will be in 3 decimal places
    while True:

        t_start = time()
    
        df = next(df_iter)
    
        df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
        df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

        df.to_sql(name=table_name, con=engine, if_exists='append')

        t_end = time()

        print('inserted another cunk, took %.3f second' %(t_end - t_start))

if __name__ == '__main__':
    #for more information on argparse check this page out -> https://docs.python.org/3/library/argparse.html
    #for more information on the main block, check this page out -> https://docs.python.org/3/library/__main__.html
    parser = argparse.ArgumentParser(description='Ingest CSV data to Postgres')

    parser.add_argument('--user', help='user name for postgres')
    parser.add_argument('--password', help='password for postgres')
    parser.add_argument('--host', help='host for postgres')
    parser.add_argument('--port', help='port for postgres')
    parser.add_argument('--db', help='databasename for postgres')
    parser.add_argument('--table_name', help='name of the table where the result will be written')
    parser.add_argument('--url', help='url of the csv file')

    args = parser.parse_args()
    #print(args.accumulate(args.integers))

    main(args)