-- create a grouping set for three columns labeled year, category, and sum of billedamount
select year,category, sum(billedamount) as totalbilledamount
from "FactBilling"
left join "DimCustomer"
on "FactBilling".customerid = "DimCustomer".customerid
left join "DimMonth"
on "FactBilling".monthid="DimMonth".monthid
group by grouping sets(year,category);



--- rollup 
select year,category, sum(billedamount) as totalbilledamount
from "FactBilling"
left join "DimCustomer"
on "FactBilling".customerid = "DimCustomer".customerid
left join "DimMonth"
on "FactBilling".monthid="DimMonth".monthid
group by rollup(year,category)
order by year, category;


-- cube
select year,category, sum(billedamount) as totalbilledamount
from "FactBilling"
left join "DimCustomer"
on "FactBilling".customerid = "DimCustomer".customerid
left join "DimMonth"
on "FactBilling".monthid="DimMonth".monthid
group by cube(year,category)
order by year, category;


-- MView
CREATE MATERIALIZED VIEW countrystats (country, year, totalbilledamount) AS
(select country, year, sum(billedamount)
from "FactBilling"
left join "DimCustomer"
on "FactBilling".customerid = "DimCustomer".customerid
left join "DimMonth"
on "FactBilling".monthid="DimMonth".monthid
group by country,year);

-- Refresh
REFRESH MATERIALIZED VIEW countrystats;

-- Query MQT
select * from countrystats;


-- Challenge Exercises (See Output in Related PDF File for Output from pgAdmin)

-- Problem 1: Create a grouping set for the columns year, quartername, sum(billedamount).
-- Mine
SELECT
	dm.year, dm.quartername, SUM(fb.billedamount)
FROM "FactBilling" AS fb
LEFT JOIN "DimMonth" AS dm
USING(monthid)
GROUP BY GROUPING SETS(dm.year, dm.quartername)
ORDER BY dm.year, dm.quartername;

-- Theirs
select year, quartername, sum(billedamount) as totalbilledamount
from "FactBilling"
left join "DimCustomer"
on "FactBilling".customerid = "DimCustomer".customerid
left join "DimMonth"
on "FactBilling".monthid="DimMonth".monthid
group by grouping sets(year, quartername);


-- Problem 2: Create a rollup for the columns country, category, sum(billedamount).
-- Mine
SELECT
	dc.country, dc.category, SUM(fb.billedamount)
FROM "FactBilling" AS fb
LEFT JOIN "DimCustomer" AS dc
USING(customerid)
GROUP BY ROLLUP(dc.country, dc.category)
ORDER BY dc.country, dc.category;


--  Problem 3: Create a cube for the columns year,country, category, sum(billedamount).
SELECT
	dm.year, dc.country, dc.category, SUM(fb.billedamount)
FROM "FactBilling" AS fb
LEFT JOIN "DimMonth" AS dm
	USING(monthid)
LEFT JOIN "DimCustomer" AS dc
	USING(customerid)
GROUP BY CUBE(dm.year, dc.country, dc.category)
ORDER BY dm.year, dc.country, dc.category;

