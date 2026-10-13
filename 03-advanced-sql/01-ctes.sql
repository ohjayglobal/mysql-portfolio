-- =====================================================================
-- Module 03: Advanced SQL
-- Script: 01-ctes.sql
-- Description: Common Table Expressions (CTEs), readability improvements 
--              over subqueries, and multi-CTE query chains.
-- Database: parks_and_recreation
-- =====================================================================

USE parks_and_recreation;

-- 1. Single CTE Architecture
-- A CTE defines a temporary named result set accessible within the execution scope of the primary query.
WITH CTE_Example AS (
    SELECT 
        gender, 
        AVG(salary) AS avg_sal, 
        MAX(salary) AS max_sal, 
        MIN(salary) AS min_sal, 
        COUNT(salary) AS count_sal
    FROM employee_demographics dem
    JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
SELECT *
FROM CTE_Example;

-- 2. Multi-CTE Chained Architecture
-- Chaining independent sub-analyses together via comma-separated CTE blocks
WITH Demographic_Filter AS (
    SELECT 
        employee_id, 
        gender, 
        birth_date
    FROM employee_demographics 
    WHERE birth_date > '1985-01-01'
),
High_Earners AS (
    SELECT 
        employee_id, 
        salary
    FROM employee_salary 
    WHERE salary > 50000
)
SELECT 
    df.employee_id,
    df.gender,
    df.birth_date,
    he.salary
FROM Demographic_Filter df
INNER JOIN High_Earners he
    ON df.employee_id = he.employee_id;
