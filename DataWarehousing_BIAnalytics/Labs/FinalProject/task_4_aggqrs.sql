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