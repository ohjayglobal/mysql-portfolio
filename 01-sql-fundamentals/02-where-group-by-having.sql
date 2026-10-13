-- =====================================================================
-- Module 01: SQL Fundamentals
-- Script: 02-where-group-by-having.sql
-- Description: Row filtering (WHERE), aggregation (GROUP BY), aggregate 
--              filtering (HAVING), and sorting (ORDER BY).
-- Database: parks_and_recreation
-- =====================================================================

USE parks_and_recreation;

-- 1. Inspect parks departments reference table
SELECT * 
FROM parks_departments;

-- 2. Basic row filtering using WHERE
SELECT *
FROM employee_demographics
WHERE gender = 'Male';

-- 3. Categorical aggregation using GROUP BY
SELECT gender
FROM employee_demographics
GROUP BY gender;

-- 4. Aggregate metrics by demographic category (AVG, MAX, MIN, COUNT)
SELECT 
    gender, 
    AVG(age) AS avg_age, 
    MAX(age) AS max_age, 
    MIN(age) AS min_age, 
    COUNT(age) AS total_count
FROM employee_demographics
GROUP BY gender;

-- 5. Sorting results using ORDER BY (Ascending & Descending)
SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

SELECT *
FROM employee_demographics
ORDER BY first_name ASC;

-- Multi-column sorting: group by primary criteria, then secondary criteria
SELECT *
FROM employee_demographics
ORDER BY gender ASC, age DESC;

-- 6. Combining WHERE, GROUP BY, and HAVING
-- WHERE filters individual records BEFORE aggregation
-- HAVING filters aggregated groups AFTER GROUP BY
SELECT 
    occupation, 
    AVG(salary) AS avg_salary
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000;
