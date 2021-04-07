-- Practicing SQL using SQL Shack
-- https://www.sqlshack.com/learn-sql-sql-query-practice/

-- Learn SQL: Practice SQL Queries
-- Always look at Data Models to see what is available and where things are
-- SQL Practice #1 - Aggregating & LEFT JOIN
SELECT
    country.country_name_eng
    , COUNT(city.id) AS number_of_cities -- Count the number of cities in each country
FROM country
LEFT JOIN city ON country.id = city.country_id
-- Note on LEFT JOIN
-- LEFT JOIN returns all rows from left table even if there are no matches in the
-- right table. Rows that don't have a match  will have NULLs. Basically returns
-- all records from left table no matter if they have a pair in the right table.
-- In this case, we use a LEFT JOIN because we want all of the countries,
-- even if there are that country has no cities
GROUP BY country.id, country.country_name_eng
ORDER BY country.country_name_eng ASC;

-- SQL Practice #2 - Combining Subquery & Aggregate Function
SELECT
  customer.id,
  customer.customer_name,
  COUNT(call.id) AS calls -- Count the number of calls each customer made
FROM customer
INNER JOIN call ON call.customer_id = customer.id
-- INNER JOIN only returns rows where the join condition matches
GROUP BY
  customer.id,
  customer.customer_name
HAVING COUNT(call.id) >  -- We want only the customers that made more than the average
    (                    -- number of calls
    SELECT CAST(COUNT(*) AS DECIMAL(5,2)) /
            CAST(COUNT(DISTINCT customer_id) AS DECIMAL(5,2))
    FROM call  -- Divide the count of all rows by the number of customer ids
    );


