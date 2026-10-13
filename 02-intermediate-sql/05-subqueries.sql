-- =====================================================================
-- Module 02: Intermediate SQL
-- Script: 05-subqueries.sql
-- Description: Subqueries in WHERE clause (membership filtering), 
--              SELECT clause (scalar subqueries), and FROM clause (derived tables).
-- Database: parks_and_recreation
-- =====================================================================

USE parks_and_recreation;

-- 1. Subquery in WHERE Clause: Membership Filtering
-- Retrieve demographic records for employees working in Department 1
SELECT *
FROM employee_demographics
WHERE employee_id IN (
    SELECT employee_id
    FROM employee_salary
    WHERE dept_id = 1
);

-- 2. Scalar Subquery in SELECT Clause
-- Compares individual employee salaries directly against overall organization average
SELECT 
    first_name, 
    salary,
    (SELECT AVG(salary) FROM employee_salary) AS org_avg_salary,
    salary - (SELECT AVG(salary) FROM employee_salary) AS variance_from_avg
FROM employee_salary;

-- 3. Derived Table (Subquery in FROM Clause)
-- Calculate aggregate metrics on an already-aggregated demographic table
SELECT 
    AVG(max_age) AS overall_avg_of_max_age,
    AVG(avg_age) AS overall_grand_avg_age
FROM (
    SELECT 
        gender,
        AVG(age) AS avg_age,
        MAX(age) AS max_age,
        MIN(age) AS min_age,
        COUNT(age) AS group_count
    FROM employee_demographics
    GROUP BY gender
) AS agg_table;
