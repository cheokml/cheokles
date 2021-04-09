-- SQL Problems in YouTube Videos

-- https://www.youtube.com/watch?v=uLCFCzVLi4Q
-- Part 1. Find top 5 employees who get paid the least and have done more than 10 projects
WITH tmp AS (
    SELECT
        employee_id
        , COUNT(end_dt) AS projects_completed
    FROM Projects
    GROUP BY 1
    HAVING COUNT(end_dt) >= 10
)

SELECT
    e.id
    , e.Salary
    , p.projects_completed
FROM
    Employees e
JOIN tmp p ON e.id = p.employee_id  -- Inner JOIN because we don't care about people who did less that 10
ORDER BY e.Salary ASC
LIMIT 5;
-- Alternative
SELECT
    e.id
    , e.Salary
    , COUNT(p.end_dt) AS projects_completed
FROM
    Employees e
JOIN Projects p on e.id = p.employee_id
GROUP BY 1, 2
HAVING COUNT(p.end_dt) >= 10
ORDER BY e.Salary ASC
LIMIT 5;

-- Part 2. Find total salary of all employees who have not yet completed a project
SELECT
    SUM(Salary) AS Total_Salary
FROM
    Employees e
JOIN
    (
        SELECT employee_id
        FROM Projects
        GROUP BY employee_id
        HAVING
            COUNT(p.end_dt) IS NULL
            OR COUNT(p.end_dt > CURRENT_DATE() )
    );
-- Alternative
SELECT SUM(e.Salary)
FROM Employees e
WHERE e.id IN
    (
        SELECT DISTINCT employee_id     -- SELECT all the distinct employee ID's
        FROM Projects                   -- WHERE the end_dt is null -> Then we can sum all the salaries of all of these
        WHERE end_dt IS NULL            -- employees
    );

-- Part 3. Determine who gets raises
-- 1. How many projects completed/How many projects assigned
-- 2. ORDER BY salary
SELECT
    e.id
    , e.Salary
    , COUNT(CASE WHEN end_dt IS NOT NULL THEN 1 ELSE 0 END) AS projects_completed
    , COUNT(project_id) AS total_projects
    , COUNT(CASE WHEN end_dt IS NOT NULL THEN 1 ELSE 0 END) / COUNT(project_id) AS pct_completed
FROM Employees e
LEFT JOIN Projects p ON e.id = p.employee_id  -- Maybe we want to see who hasn't been assigned a project
GROUP BY 1, 2
ORDER BY Salary ASC ;


-- https://www.interviewquery.com/blog-sql-interview-questions/
-- Questions
-- Would tables be joined on neighborhood_id and city_id or id?
SELECT n.name
FROM neighborhoods AS n
LEFT JOIN users AS u
    ON n.id = u.neighborhood_id
WHERE u.id IS NULL ;

-- What's the total distance traveled for all riders on Lyft in the month of March?
SELECT
    user
    , SUM(distance) AS Total_Distance
FROM Travels
WHERE month(datetime) = '2021-03-01'
GROUP BY user;

-- How many bookings did Airbnb get in the month of December?
SELECT count(booking_id) AS Total_Bookings
FROM Logs
WHERE month(datetime) = '2021-03-01';

-- https://www.interviewquery.com/questions/cumulative-reset
-- Find every day's cumulative sum for that month and reset every month
--
WITH daily_total AS (
    SELECT
        DATE(created_at) AS dt
       , COUNT(*) AS cnt
    FROM users
    GROUP BY 1
)

SELECT
    t.dt AS date
    , SUM(u.cnt) AS monthly_cumulative
FROM daily_total AS t
LEFT JOIN daily_total AS u
    ON t.dt >= u.dt
        AND MONTH(t.dt) = MONTH(u.dt)
        AND YEAR(t.dt) = YEAR(u.dt)
GROUP BY t.dt ;