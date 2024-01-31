
docker run -it \
-e POSTGRES_USER="root" \
-e POSTGRES_PASSWORD="root" \
-e POSTGRES_DB="ny_taxi" \
-v c:\Users\hauwa.muibi\source\repos\HauwaZoomcamp2024\docker_sql\ny_taxi_postgres_data:/var/lib/postgresql/data \
-p 5432:5432 \
postgres:13

docker run -it \
-e POSTGRES_USER="root" \
-e POSTGRES_PASSWORD="root" \
-e POSTGRES_DB="ny_taxi" \
-v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
-p 5432:5432 \
postgres:13

C:\Users\hauwa.muibi\source\repos\HauwaZoomcamp2024\docker_sql\ny_taxi_postgres_data

pgcli -h localhost -p 5432 -u root -d ny_taxi

/workspaces/HauwaZoomcamp2024/docker_sql/ny_taxi_postgres_data

docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  --network=pg-network \
  --name pgadmin-2 \
  dpage/pgadmin4
  
  
  
  
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v dtc_postgres_volume_local:/var/lib/postgresql/data \
  -p 5432:5432 \
  --network=pg-network \
  --name pg-database \
  postgres:13  
  

    #The python to execute this script

#Tomorrow run this first 
docker start pg-database
docker start pgadmin-2

URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"

python ingest_data.py \
--user=root \
--password=root \
--host=localhost \
--port=5432 \
--db=ny_taxi \
--table_name=yellow_taxi_trips \
--url=${URL}

URL = "!wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz"
python ingest_data.py \
--user=root \
--password=root \
--host=localhost \
--port=5432 \
--db=ny_taxi \
--table_name=green_taxi_trips \
--url=${URL}


docker build -t taxi_ingest:v001 .

The name of the image is taxi_ingest:v001
--network=pg-network \ -- this is a parameter for docker 
--the rest are parameters for our job

docker run -it \
--network=pg-network \
taxi_ingest:v001 \
--user=root \
--password=root \
--host=localhost \
--port=5432 \
--db=ny_taxi \
--table_name=yellow_taxi_trips \
--url=${URL}

The run this 
docker run -it --network=pg-network taxi_ingest:v001 --user=root --password=root --host=pg-database --port=5432 --db=ny_taxi --table_name=yellow_taxi_trips --url=${URL}


URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"
python ingest_data.py \
  --user=root \
  --password=root \
  --host=localhost \
  --port=5432 \
  --db=ny_taxi \
  --table_name=yellow_taxi_trips \
  --url=${URL}

  Run this then log in 

  docker-compose up 

  docker-compose down 

  docker-compose up -d - running in detached mode

  everytime you connect 
  rerun docker compose
  add server - Docker localhost 
  pgdatabase root then root



SELECT tpep_pickup_datetime, tpep_dropoff_datetime, 
total_amount, 
CONCAT(zpu."Borough", '/', zpu."Zone") AS "pickup_loc",
CONCAT(zdo."Borough", '/', zpu."Zone") as "droppff_loc",
DATE_tRUNC('DAY', tpep_dropoff_datetime),
CAST(tpep_dropoff_datetime AS DATE)
FROM public.yellow_taxi_data t join zones zpu
on t."PULocationID" = zpu."LocationID" join zones zdo
on t."PULocationID" = zdo."LocationID" 
LIMIT 100



SELECT 
CAST(tpep_dropoff_datetime AS DATE) AS "DAY", --total_amount, 
COUNT(1)
FROM public.yellow_taxi_data t 
GROUP BY CAST(tpep_dropoff_datetime AS DATE)


SELECT tpep_pickup_datetime, tpep_dropoff_datetime, 
total_amount,  "PULocationID", "DOLocationID"
FROM public.yellow_taxi_data 
WHERE "PULocationID" NOT IN 
(SELECT "LocationID" FROM ZONES)
LIMIT 100

terraform fmt - heps to format everything. 
terraform init 
terraform plan
terraform apply