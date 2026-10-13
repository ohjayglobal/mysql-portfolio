-- =====================================================================
-- Module 02: Intermediate SQL
-- Script: 04-case-statements.sql
-- Description: Conditional branching, data classification, and dynamic 
--              calculations using CASE WHEN THEN ELSE END.
-- Database: parks_and_recreation
-- =====================================================================

USE parks_and_recreation;

-- 1. Demographic Categorization
-- Segmenting employees into age brackets
SELECT 
    first_name,
    last_name,
    age,
    CASE 
        WHEN age <= 30 THEN 'Young Career (<=30)' 
        WHEN age BETWEEN 31 AND 50 THEN 'Mid Career (31-50)' 
        WHEN age > 50 THEN 'Senior Career (>50)'
    END AS career_stage
FROM employee_demographics;

-- 2. Financial Compensation Modeling
-- Conditional salary increments and department-specific performance bonuses
SELECT 
    first_name, 
    last_name, 
    salary,
    -- Tiered salary increment based on threshold
    CASE
        WHEN salary < 50000 THEN salary * 1.05
        WHEN salary >= 50000 THEN salary * 1.07
    END AS updated_salary,
    -- Department 6 (Finance) special incentive
    CASE
        WHEN dept_id = 6 THEN salary * 0.10
        ELSE 0
    END AS annual_bonus
FROM employee_salary;
