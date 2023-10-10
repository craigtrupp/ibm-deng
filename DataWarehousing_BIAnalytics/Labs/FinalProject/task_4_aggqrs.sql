-- Exercise 4 - Write aggregation queries and create MQTs

-- Task 13 - Create a grouping sets query
-- Create a grouping sets query using the columns stationid, trucktype, total waste collected.

-- Take a screenshot of the sql and the output rows.
-- Create a grouping sets query using the columns stationid, trucktype, total waste collected.
SELECT 
	ft.stationid, dt.trucktype, SUM(ft.wastecollected) AS total_waste
FROM FACTTRIPS AS ft 
LEFT JOIN DIMTRUCK AS dt
	ON ft.truckid = dt.truckid
GROUP BY GROUPING SETS(ft.stationid, dt.trucktype)
ORDER BY total_waste DESC;



-- Task 14 - Create a rollup query
-- Create a rollup query using the columns year, city, stationid, and total waste collected.

-- Take a screenshot of the sql and the output rows.
-- Create a rollup query using the columns year, city, stationid, and total waste collected.
SELECT 
	 dd.year, ds.city, ft.stationid, SUM(ft.wastecollected) AS total_waste
FROM FACTTRIPS AS ft
LEFT JOIN DIMDATE AS dd 
	USING(dateid)
LEFT JOIN DIMSTATION AS ds
	USING(stationid)
GROUP BY ROLLUP(dd.year, ds.city, ft.stationid)
ORDER BY dd.year, ft.stationid;

-- Note on task 14 : See the Outputs for this particular query, the rollup performs group type aggregations for the three columns above
-- then does a group of two groupby aggregation for city and year
-- and lastly does a singular aggregation for the year by itself

-- |Year|City|Stationid|total|waste
-- |2019	|Brasilia|	97	    |140485.97|
-- |2019	|		 |           |3395632.49|
-- |2019	|Brasilia|		    |848742.31|
-- |2019	|Rio de Janeiro|		|848303.62|


-- Task 15 - Create a cube query
-- Create a cube query using the columns year, city, stationid, and average waste collected.

-- Take a screenshot of the sql and the output rows.
-- Create a cube query using the columns year, city, stationid, and average waste collected.
SELECT 
	 dd.year, ds.city, ft.stationid, ROUND(AVG(ft.wastecollected), 3) AS avg_waste
FROM FACTTRIPS AS ft
LEFT JOIN DIMDATE AS dd 
	USING(dateid)
LEFT JOIN DIMSTATION AS ds
	USING(stationid)
GROUP BY CUBE(dd.year, ds.city, ft.stationid)
ORDER BY dd.year, ft.stationid;

-- Note on task 14 : You can see here that each column in a cube will pull an aggregate for all columns together, each unique pair, then it's own column by itself

-- |Year|       City        | StationID |  avg_waste                   |
-- |2019|		            |97	        |37.543000000000000000000000000|
-- |2019|	Rio de Janeiro	|86	        |37.399000000000000000000000000|
-- |2019|	Brasilia	    |97	        |37.543000000000000000000000000|
-- |2019|	Brasilia		|           |37.475000000000000000000000000|
-- |2019|	Rio de Janeiro	|	        |37.456000000000000000000000000|
-- |2019|	Salvador		|           |37.485000000000000000000000000|
-- |2019|	Sao Paulo		|           |37.514000000000000000000000000|
-- |2019|			        |           |37.483000000000000000000000000|





-- Task 16 - Create an MQT
-- Create an MQT named max_waste_stats using the columns city, stationid, trucktype, and max waste collected.
-- https://www.ibm.com/docs/en/db2-for-zos/13?topic=rewrite-creating-materialized-query-table

-- Create an MQT named max_waste_stats using the columns city, stationid, trucktype, and max waste collected.
DROP TABLE IF EXISTS cds03902.max_waste_stats;
CREATE TABLE max_waste_stats(city, stationid, trucktype, max_waste) AS 
(SELECT dst.city AS city, dst.stationid AS stationid, dt.trucktype, MAX(ft.wastecollected) AS max_waste
FROM FACTTRIPS AS ft 
LEFT JOIN DIMSTATION AS dst 
	ON ft.stationid = dst.stationid
LEFT JOIN DIMTRUCK AS dt
	ON ft.truckid = dt.truckid
GROUP BY dst.city, dst.stationid, dt.trucktype)
DATA INITIALLY DEFERRED 
REFRESH DEFERRED 
MAINTAINED BY SYSTEM;

REFRESH TABLE max_waste_stats;

SELECT * FROM max_waste_stats;
