-- =====================================================================
-- Module 02: Intermediate SQL
-- Script: 02-unions.sql
-- Description: Combining result sets vertically using UNION, deduplication 
--              behavior, and custom conditional labeling.
-- Database: parks_and_recreation
-- =====================================================================

USE parks_and_recreation;

-- 1. Standard UNION (Removes duplicate rows automatically)
SELECT first_name, last_name
FROM employee_demographics
UNION 
SELECT first_name, last_name
FROM employee_salary;

-- 2. Practical Business Query: Segmentation & Labeling
-- Combining distinct subsets of data into a consolidated reporting feed
SELECT 
    first_name, 
    last_name, 
    'Senior Male Employee' AS demographic_segment
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'

UNION 

SELECT 
    first_name, 
    last_name, 
    'Senior Female Employee' AS demographic_segment
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'

UNION

SELECT 
    first_name, 
    last_name, 
    'Highly Compensated Employee' AS demographic_segment
FROM employee_salary
WHERE salary > 70000

ORDER BY first_name, last_name;
