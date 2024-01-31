
select CAST(lpep_dropoff_datetime AS DATE) AS "DAY", * from green_Taxi_data order by lpep_dropoff_datetime

select count(*) from green_taxi_data
select * from green_taxi_data limit 100
select * from zones where "Zone" = 'Astoria'

--Question 3 --15,767
select count(*) from green_taxi_data
where CAST(lpep_pickup_datetime AS DATE) = '2019-09-18' AND CAST(lpep_dropoff_datetime AS DATE) = '2019-09-18'

--Question 4  --2019-09-26
select * From (
select CAST(lpep_pickup_datetime AS DATE) AS "DAY", CAST(sum("trip_distance") AS DECIMAL(22,4)) AS Trip_distance 
from green_taxi_data 
group by CAST(lpep_pickup_datetime AS DATE)) a 
order by trip_distance DESC

--Question 5  --Brooklyn, Manhattan, Queens
select * from (
select "Borough", sum("total_amount") as total_amount from green_taxi_data g join zones z on g."PULocationID" = z."LocationID"
where CAST(lpep_pickup_datetime AS DATE) = '2019-09-18' and "Borough" <> 'Unknown'
group by "Borough") a
where total_amount > 50000


--Question 6  --"Long Island City/Queens Plaza"
SELECT * FROM (
SELECT  "Zone",  SUM("tip_amount") AS tip_amount
from green_taxi_data g join zones z on g."PULocationID" = z."LocationID"
WHERE to_char(lpep_pickup_datetime, 'YYYY-MM') = '2019-09'  AND g."DOLocationID" = 7
	AND z."Zone" IN ('Central Park', 'Jamaica', 'JFK Airport', 
'Long Island City/Queens Plaza')
GROUP BY "Zone") A
ORDER BY tip_amount DESC

/*
select "Zone", sum("tip_amount") as tip_amount From green_taxi_data g join zones z on g."PULocationID" = z."LocationID"
WHERE to_char(lpep_pickup_datetime, 'YYYY-MM') = '2019-09' 
and z."Zone" IN ('Central Park', 'Jamaica', 'JFK Airport', 
'Long Island City/Queens Plaza')group by "Zone"

select count(*) From green_taxi_data WHERE 
CAST(lpep_pickup_datetime AS DATE) >= '2019-09-01' and CAST(lpep_pickup_datetime AS DATE) <= '2019-09-30'*/


