-- =====================================================================
-- Module 02: Intermediate SQL
-- Script: 06-window-functions.sql
-- Description: Analytical window functions: PARTITION BY, cumulative rolling 
--              aggregations, ROW_NUMBER(), RANK(), and DENSE_RANK().
-- Database: parks_and_recreation
-- =====================================================================

USE parks_and_recreation;

-- 1. Cumulative Rolling Total using Window Functions
-- Calculates running sum of salary within each gender partition ordered by employee_id
SELECT 
    dem.first_name, 
    dem.last_name, 
    dem.gender, 
    sal.salary,
    SUM(sal.salary) OVER(
        PARTITION BY dem.gender 
        ORDER BY dem.employee_id
    ) AS rolling_salary_total
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- 2. Comparative Ranking Functions: ROW_NUMBER vs. RANK vs. DENSE_RANK
-- Compares distinct behaviors when ordering salaries within gender partitions:
--   - ROW_NUMBER(): Unique sequential integer per row (no ties).
--   - RANK(): Leaves gaps in numbering after ties.
--   - DENSE_RANK(): Consecutive numbering with no gaps after ties.
SELECT 
    dem.employee_id, 
    dem.first_name, 
    dem.last_name, 
    dem.gender, 
    sal.salary,
    ROW_NUMBER() OVER(
        PARTITION BY dem.gender 
        ORDER BY sal.salary DESC
    ) AS row_num,
    RANK() OVER(
        PARTITION BY dem.gender 
        ORDER BY sal.salary DESC
    ) AS rank_num,
    DENSE_RANK() OVER(
        PARTITION BY dem.gender 
        ORDER BY sal.salary DESC
    ) AS dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;
