-- =====================================================================
-- Module 01: SQL Fundamentals
-- Script: 03-limit-and-aliasing.sql
-- Description: Result limiting (LIMIT), pagination patterns, and column 
--              aliasing (AS) in aggregated queries.
-- Database: parks_and_recreation
-- =====================================================================

USE parks_and_recreation;

-- 1. Using LIMIT with ORDER BY for top-N analysis
-- Finds the 3 oldest employees
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3;

-- 2. Column Aliasing with aggregate filtering
-- Demonstrates HAVING using the alias vs. using the aggregate expression
SELECT 
    gender, 
    AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;

-- Equivalent standard SQL query using aggregate function directly in HAVING
SELECT 
    gender, 
    AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;
