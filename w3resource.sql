-- Practice SQL Problems
-- Answering all SQL problems + notes on shortcuts
-- https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php#SQLEDITOR

-- Retrieving data from tables
-- 1. Write a SQL statement to display all the information of all salesmen.
SELECT * -- * SELECTS all rows
FROM salesman;

-- 2. Write a SQL statement to display a string
--      "This is SQL Exercise, Practice and Solution".
SELECT
    "This is SQL Exercise, Practice and Solution"; -- Selects 1 column with 1 row that has this string

-- 3. Write a query to display three numbers in three columns.
SELECT
    1, 2, 3; -- Generates 3 columns and 1 row -> Each number in one column

-- 4. Write a query to display the sum of two numbers 10 and 15 from RDMS sever.
SELECT (1+2) AS sum; -- Use + to add numbers and SUM to add rows in a column together

-- 5. Write a query to display the result of an arithmetic expression.
SELECT (1+2*3/7) AS math;

-- 6. Write a SQL statement to display specific columns like name and commission
--      for all the salesmen.
SELECT salesman_id, commission
FROM salesman;

-- 7. Write a query to display the columns in a specific order like
--      order date, salesman id, order number and purchase amount from for all the orders.
SELECT ord_date, salesman_id, ord_no, SUM(purch_amt) AS purch_amt
FROM orders
GROUP BY ord_date, salesman_id, ord_no;

-- 8. Write a query which will retrieve the value of salesman id of all salesmen,
--      getting orders from the customers in orders table without any repeats.
SELECT DISTINCT -- Distinct only returns all unique rows from the columns selected
    salesman_id
FROM orders;

-- 9. Write a SQL statement to display names and
--      city of salesman, who belongs to the city of Paris.
SELECT name, city
FROM salesman
WHERE city = "Paris";

-- 10. Write a SQL statement to display all the
--      information for those customers with a grade of 200.
SELECT *
FROM customer
WHERE grade = 200; -- If column is a number type you don't need quotes around number

-- 11. Write a SQL query to display the order number followed by order date
--      and the purchase amount for each order which will be delivered by the
--      salesman who is holding the ID 5001.
SELECT
    ord_no
    , ord_date
    , SUM(purch_amt) AS purchase_amt
FROM orders
WHERE salesman_id = 5001
GROUP BY 1, 2;

-- 12. Write a SQL query to display the Nobel prizes for 1970.
SELECT subject
FROM nobel_win
WHERE year = 1970

-- 13. Write a SQL query to know the winner of the 1971 prize for Literature.
SELECT winner
FROM nobel_win
WHERE
    year = 1971
    AND subject = "Literature";

-- 14. Write a SQL query to display the year and subject that
--      won 'Dennis Gabor' his prize.
SELECT
    year, subject
FROM nobel_win
WHERE winner = 'Dennis Gobar';

--15. Write a SQL query to give the name of the 'Physics'
--      winners since the year 1950.
SELECT
    winner
FROM nobel_win
WHERE
    subject = "Physics"
    AND year > 1950;

-- 16. Write a SQL query to Show all the details (year, subject, winner, country )
--      of the Chemistry prize winners between the year 1965 to 1975 inclusive.
SELECT *
FROM nobel_win
WHERE
    subject = 'Chemistry'
    AND year BETWEEN 1965 AND 1975;

-- 17. Write a SQL query to show all details of the Prime Ministerial
--      winners after 1972 of Menachem Begin and Yitzhak Rabin.
SELECT *
FROM nobel_win
WHERE
    year > 1972
    AND name IN ('Menachem Begin', 'Yitzhak Rabin')
    AND category = 'Prime Minister';

-- 18. Write a SQL query to show all the details of the winners with first name Louis.
SELECT *
FROM nobel_win
WHERE winner LIKE 'Louis %';

-- 19. Write a SQL query to show all the winners in Physics for 1970
--      together with the winner of Economics for 1971.
SELECT winner
FROM nobel_win
WHERE (year = 1970 AND subject = 'Physics')
UNION -- Union selects distinct | Union All allows duplicates
SELECT winner
FROM nobel_win
WHERE (year = 1971 AND subject = 'Economics');

-- 20. Write a SQL query to show all the winners of nobel prize
--      in the year 1970 except the subject Physiology and Economics.
SELECT winner
FROM nobel_win
WHERE
    year = 1970
    AND subject NOT IN ('Physiology', 'Economics');

-- 21. Write a SQL query to show the winners of a 'Physiology' prize in an
--      early year before 1971 together with winners of a 'Peace' prize in a
--      later year on and after the 1974.
SELECT winner
FROM nobel_win
WHERE (year < 1971 AND subject = 'Physiology')
UNION
SELECT winner
FROm nobel_win
WHERE (year >= 1974 AND subject = 'Peace');

-- 22. Write a SQL query to find all details of the prize won
--      by Johannes Georg Bednorz.
SELECT *
FROM nobel_win
WHERE winner = 'Johannes Georg Bednorz';

-- 23. Write a SQL query to find all the details of the nobel winners for the
--      subject not started with the letter 'P' and arranged the list as the
--      most recent comes first, then by name in order.
SELECT *
FROM nobel_win
WHERE
    subject NOT LIKE 'P%'
ORDER BY
    year DESC
    , winner ASC;

-- 24. Write a SQL query to find all the details of 1970 winners by the ordered
--      to subject and winner name; but the list contain the subject Economics
--      and Chemistry at last.
SELECT *
FROM nobel_win
WHERE year = 1970
ORDER BY
    CASE WHEN subject IN ('Economics', 'Chemistry') -- Order by the values assigned to row
        THEN 1 -- When subject is in list, assign the number 1 to it
        ELSE 0 END ASC -- When subject not in list, assign 0 to it
    , subject
    , winner;

-- 25. Write a SQL query to find all the products with a price between
--      Rs.200 and Rs.600.
SELECT pro_name
FROM item_mast
WHERE pro_price BETWEEN 200 AND 600;

-- 26. Write a SQL query to calculate the average price of all products
--      of the manufacturer which code is 16.
SELECT AVG(pro_price)
FROM item_mast
WHERE pro_com = 16;

-- 27. Write a SQL query to find the item name and price in Rs.
SELECT
    pro_name
    , pro_price
FROM item_mast;

-- 28. Write a SQL query to display the name and price of all the items with
--      a price is equal or more than Rs.250, and the list contain the larger
--      price first and then by name in ascending order.
SELECT
    pro_name
    , pro_price
FROM item_mast
WHERE pro_price >= 250
ORDER BY
    pro_price DESC
    , pro_name ASC;

-- 29. Write a SQL query to display the average price of the items for each company,
--      showing only the company code.
SELECT
    pro_com
    , AVG(pro_price)
FROM item_mast
GROUP BY pro_com;

-- 30. Write a SQL query to find the name and price of the cheapest item(s).
SELECT
    pro_name
    , pro_price
FROM item_mast
ORDER BY pro_price ASC
LIMIT 1; -- This selects the cheapest item and returns it
-- Alternative Answer
SELECT
    pro_name
    , pro_price
FROM item_mast
WHERE pro_price = (SELECT MIN(pro_price) FROM item_mast);
-- This subquery selects the lowest price in the price column and returns it

-- 31. Write a query in SQL to find the last name of all employees, without duplicates.
SELECT DISTINCT emp_lname
FROM emp_details;

-- 32. Write a query in SQL to find the data of employees whose last name is 'Snares'.
SELECT *
FROM emp_details
WHERE emp_lname = 'Snares';

-- 33. Write a query in SQL to display all the data of employees that work
--      in the department 57.
SELECT *
FROM emp_details
WHERE emp_dept = 57;


-- Using Boolean and Relational Operators
-- These were really poorly worded questions
-- 1. Write a query to display all customers with a grade above 100.
SELECT cust_name
FROM customer
WHERE grade > 100;

-- 2. Write a query statement to display all customers in New York who have a grade
--      value above 100.
SELECT cust_name
FROM customer
WHERE
    grade > 100
    AND city = 'New York';

-- 3. Write a SQL statement to display all customers, who are either belongs to the
--      city New York or had a grade above 100.
SELECT cust_name
FROM customer
WHERE
    grade > 100
    OR city = 'New York';

-- 4. Write a SQL statement to display all the customers, who are either belongs
--      to the city New York or not had a grade above 100.
SELECT cust_name
FROM customer
WHERE
    city = 'New York'
    OR NOT grade > 100;

-- 5.Write a SQL query to display those customers who are neither belongs to the
--      city New York nor grade value is more than 100.
SELECT cust_name
FROM customer
WHERE NOT (
    city = 'New York'
    OR grade > 100) ;

-- 6. Write a SQL statement to display either those orders which are not issued on
--      date 2012-09-10 and issued by the salesman whose ID is 5005 and below or
--      those orders which purchase amount is 1000.00 and below.
SELECT ord_no
FROM orders
WHERE NOT ((                 -- Where orders were not
    ord_date = '2012-09-10'  -- on 2012-09-10
    AND salesman_id > 5005)  -- AND not greater than 5005 (less than 5005)
    OR purch_amt > 1000.00); -- or purchase amount

-- 7. Write a SQL statement to display salesman_id, name, city and commission who
--      gets the commission within the range more than 0.10% and less than 0.12%.
SELECT
    salesman_id
    , name
    , city
    , commission
FROM salesman
WHERE
    commission > 0.10
    AND commission < 0.12;

-- 8. Write a SQL query to display all orders where purchase amount less than 200
--      or exclude those orders which order date is on or greater than 10th Feb,2012
--      and customer id is below 3009.
SELECT ord_no
FROM orders
WHERE
    purch_amt < 200
    OR (ord_date < '2012-02-10' AND customer_id >= 3009);

-- 9. Write a SQL statement to exclude the rows which satisfy 1) order dates are
--      2012-08-17 and purchase amount is below 1000 2) customer id is greater
--      than 3005 and purchase amount is below 1000.
SELECT *
FROM orders
WHERE NOT
    (ord_date = '2012-08-17' AND purch_amt < 1000)
    AND (customer_id > 3005 purch_amt < 1000);


-- Query on Multiple Tables
-- 1. Write a query to find those customers with their name and those salesmen
--      with their name and city who lives in the same city.
SELECT
    s.city
    , s.name
    , c.name
FROM
    (
    SELECT name, city
    FROM salesman
    ) s
JOIN
    (
    SELECT cust_name, city
    FROM customer
    ) c ON s.city = c.city;
