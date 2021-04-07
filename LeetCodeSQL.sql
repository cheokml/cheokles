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
  RETURN (
      # Write your MySQL query statement below.

  );
END