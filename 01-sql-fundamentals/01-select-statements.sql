-- =====================================================================
-- Module 01: SQL Fundamentals
-- Script: 01-select-statements.sql
-- Description: Basic SELECT queries, column selection, arithmetic 
--              calculations, and DISTINCT values.
-- Database: parks_and_recreation
-- =====================================================================

USE parks_and_recreation;

-- 1. Retrieve all records and columns from employee demographics
SELECT *
FROM employee_demographics;

-- 2. Select specific columns and perform computed arithmetic calculations
-- Note: Standard mathematical order of operations (PEMDAS) applies
SELECT 
    first_name, 
    last_name, 
    birth_date,
    age,
    (age + 10) * 5 + 20 AS calculated_metric
FROM employee_demographics;

-- 3. Retrieve distinct (unique) categorical values from a column
SELECT DISTINCT 
    gender
FROM employee_demographics;
