FROM python:3.9

RUN apt-get install wget
RUN pip install pandas sqlalchemy psycopg2
#package for python accessing postgres

WORKDIR /app
COPY ingest_data.py ingest_data.py  
#copying this to our docker image

ENTRYPOINT [ "python", "ingest_data.py" ]  #overriding the entrypoint, here specifying that when we use docker, we want docker to use python pipeline.py