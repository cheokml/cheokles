-- LeetCode SQL Practice Problems

-- Get second highest Salary
-- https://leetcode.com/problems/second-highest-salary/submissions/
SELECT
    (
    SELECT
    DISTINCT Salary
    FROM Employee
    WHERE Salary < (SELECT MAX(Salary)  -- This subquery makes it slower I think
                    FROM Employee )
    ORDER BY Salary DESC
    LIMIT 1
    ) AS SecondHighestSalary;
-- Faster
SELECT
    (
    SELECT DISTINCT Salary
    FROM Employee
    ORDER BY Salary DESC
    LIMIT 1
    OFFSET 1
    ) AS SecondHighestSalary;
-- Using IFNULL - Fastest
-- IFNULL( SELECT Statement, Value) <- Returns value if select statement is null
SELECT
    IFNULL((
    SELECT DISTINCT Salary
    FROM Employee
    ORDER BY Salary DESC
    LIMIT 1
    OFFSET 1), NULL
    ) AS SecondHighestSalary;


-- Get Nth highest Salary
-- https://leetcode.com/problems/nth-highest-salary/
CREATE FUNCTION     -- Call the create function
    getNthHighestSalary(N INT) -- Give function name
    RETURNS INT     -- What datatype is the function supposed to return
BEGIN       -- Begin
DECLARE M INT;  -- Declare a variable and its datatype      We do this because Limit and Offset can't
SET M = N-1;    -- Set Variable value                       calculate arithmetic so we create a variable first
  RETURN (
      # Write your MySQL query statement below.
        SELECT (
            SELECT DISTINCT Salary      -- Select the Mth Highest Salary
            FROM Employee
            ORDER BY Salary DESC
            LIMIT 1
            OFFSET M
        ) AS getNthHighestSalary
  );        -- End the query with semi colon after the return parenthesis
END


-- Find the top three salaries between two Departments
-- https://leetcode.com/problems/department-top-three-salaries/
SELECT
    d.Name as Department                     -- These are the columns we want
    , e.Name as Employee
    , e.Salary
FROM Department d
JOIN Employee e ON d.Id = e.DepartmentId     -- Join this table
WHERE
    (SELECT
            COUNT(DISTINCT Salary)           -- COUNT how many times each Salary appears
         FROM Employee                       -- WHERE makes the count Count how many salaries that salary is higher
         WHERE                               -- Where they're in the same department
            e.DepartmentId = d.Id            -- So this subquery basically COUNTs how many salaries this salary is
            AND Salary > e.Salary) < 3;      -- higher and we only want salaries have less than 3 salaries > than them.
                                             -- We use < 3 because the highest paid salary has 0 salaries higher than
                                             -- them then second highest has 1 and third highest has 2 salaries higher.
-- Another way to solve this is by using dense_rank()
-- DENSE_RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC)
-- Note: You don't NEED Partition BY
-- So this partitions the data ( Specifies which column you need to do an aggregation on but also return every record )
-- Then ranks based on what you want to order by
SELECT
    d.Name AS Department        -- This works because every department has their own top rankings
    , a. Name AS Employee
    , a. Salary
FROM (
    SELECT e.*                  -- You want all the rows
        , DENSE_RANK()          -- Rank each row by their salary and group it by the DeptId and
            OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS DeptPayRank
    FROM Employee e ) a
JOIN Department d ON a.DepartmentId = d.Id
WHERE DeptPayRank <= 3;


SELECT
    s.Score
    , Rank
FROM (*
    , DENSE_RANK()
        OVER (PARTITION BY Id ORDER BY Score DESC) AS Rank
    FROM Scores) s;


-- Rank by Score
-- https://leetcode.com/problems/rank-scores/
SELECT
    score AS 'Score'                                        -- We want the score
    , DENSE_RANK() OVER (ORDER BY Score DESC) AS 'Rank'     -- And then we can use DENSE_RANK() to rank the scores
FROM Scores;                                                -- We're not grouping by anything so drop Partition
-- Alternative
SELECT
    score AS 'Score'                                                      -- Selects how many scores >= it is to the
    , (SELECT COUNT(DISTINCT score) FROM Scores WHERE score >= s.Score) AS 'Rank'  -- first query. Order by highest
FROM Scores s                                                             -- score to least
ORDER BY Score DESC ;
-- Alternative
SELECT
  Score
  , (SELECT count(*)
     FROM
        (SELECT
         DISTINCT Score s
         FROM Scores) tmp WHERE s >= Score) Rank
FROM Scores
ORDER BY Score desc


-- Find all numbers that appear at least 3 times
-- https://leetcode.com/problems/consecutive-numbers/
SELECT DISTINCT Num AS ConsecutiveNums          -- SELECT all the unique numbers that occur consecutively 3 times
FROM Logs                                       -- The where statement checks that the number after the first
WHERE                                           -- is equal to the original number in the complete first table
    (Id + 1, Num) IN (SELECT * FROM Logs)       -- and that the number after the second number is equal to the original
    AND (ID + 2, Num) IN (SELECT * FROM Logs);  -- number.
-- Alternative
SELECT L1.Num as ConsecutiveNums from Logs L1, Logs L2, Logs L3
where L1.Id = L2.Id-1 and L2.Id = L3.ID-1
and L1.Num = L2.Num and L2.num = L3.Num

SELECT DISTINCT l1.Num AS ConsecutiveNums
FROM Logs l1
JOIN Logs l2 on l1.Id = (l2.Id + 1) AND l1.Num = l2.Num
JOIN Logs l3 on l1.Id = (l3.Id + 2) AND l1.Num = l3.Num;


-- Find all Emails that are duplicated
-- https://leetcode.com/problems/duplicate-emails/
SELECT t.Email
FROM
    (SELECT Email, COUNT(Email) AS Occ
    FROM Person
    GROUP BY Email) t
WHERE t.Occ > 1;
-- Alternative: A bit slower (tmp tables are slower than sub-queries)
WITH tmp AS (
    SELECT Email, COUNT(Email) AS Occ
    FROM Person
    GROUP BY Email
)

SELECT Email
FROM tmp
WHERE tmp.Occ > 1;


-- Find Customers that never order
-- https://leetcode.com/problems/customers-who-never-order/