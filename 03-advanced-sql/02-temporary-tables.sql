-- =====================================================================
-- Module 03: Advanced SQL
-- Script: 02-temporary-tables.sql
-- Description: Session-scoped Temporary Tables for intermediate data 
--              staging, ETL transformations, and query optimization.
-- Database: parks_and_recreation
-- =====================================================================

USE parks_and_recreation;

-- 1. Explicit Schema Temporary Table Creation
-- Temporary tables exist solely within the active MySQL connection/session 
-- and are automatically dropped when the session terminates.
CREATE TEMPORARY TABLE temp_employee_preferences (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    favorite_movie VARCHAR(100)
);

-- Verify structure
SELECT * 
FROM temp_employee_preferences;

-- Insert records into temporary table
INSERT INTO temp_employee_preferences
VALUES ('Japheth', 'Salifu', 'Abejoye');

-- Retrieve populated records
SELECT * 
FROM temp_employee_preferences;

-- 2. CREATE TEMPORARY TABLE AS SELECT (CTAS Pattern)
-- Instantly materialize query results into a temporary table for iterative analysis
DROP TEMPORARY TABLE IF EXISTS salary_over_50k;

CREATE TEMPORARY TABLE salary_over_50k AS
SELECT *
FROM employee_salary
WHERE salary >= 50000;

-- Query the staged subset
SELECT *
FROM salary_over_50k;
