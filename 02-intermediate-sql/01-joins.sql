-- =====================================================================
-- Module 02: Intermediate SQL
-- Script: 01-joins.sql
-- Description: Combining relational tables using INNER JOIN, LEFT JOIN, 
--              RIGHT JOIN, and multi-table joins.
-- Database: parks_and_recreation
-- =====================================================================

USE parks_and_recreation;

-- 1. Base inspection
SELECT *
FROM employee_demographics;

-- 2. Basic INNER JOIN
-- Returns records that have matching keys in both tables
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id;

-- 3. Targeted column selection across joined tables
SELECT 
    dem.employee_id, 
    dem.first_name,
    dem.age, 
    sal.occupation,
    sal.salary
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id;

-- 4. LEFT JOIN (Left Outer Join)
-- Returns all records from the left table (demographics) and matched records 
-- from the right table (salary), filling NULLs for non-matches
SELECT 
    dem.employee_id,
    dem.first_name,
    sal.occupation,
    sal.salary
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id;

-- 5. RIGHT JOIN (Right Outer Join)
-- Returns all records from the right table (salary) and matched records from demographics
SELECT 
    sal.employee_id,
    dem.first_name,
    sal.occupation,
    sal.salary
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id;

-- 6. Multi-table JOIN
-- Joining employee_demographics with employee_salary, then joining with parks_departments
SELECT 
    dem.employee_id,
    dem.first_name,
    dem.last_name,
    sal.occupation,
    sal.salary,
    pd.department_name
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
    ON sal.dept_id = pd.department_id;
