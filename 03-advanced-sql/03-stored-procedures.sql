-- =====================================================================
-- Module 03: Advanced SQL
-- Script: 03-stored-procedures.sql
-- Description: Stored Procedures, custom DELIMITER handling, multi-statement 
--              blocks (BEGIN ... END), and parameterized stored routines.
-- Database: parks_and_recreation
-- =====================================================================

USE parks_and_recreation;

-- 1. Base query inspection
SELECT *
FROM employee_salary
WHERE salary >= 50000;

-- 2. Basic Single-Statement Stored Procedure
DROP PROCEDURE IF EXISTS large_salaries;

CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

-- Execute stored procedure
CALL large_salaries();

-- 3. Multi-Statement Stored Procedure with Custom DELIMITER
-- MySQL requires changing the default delimiter (;) so the statement parser 
-- does not execute the inner queries prematurely before reaching END.
DROP PROCEDURE IF EXISTS get_salary_brackets;

DELIMITER $$
CREATE PROCEDURE get_salary_brackets()
BEGIN
    -- Query 1: Top tier compensation
    SELECT * 
    FROM employee_salary
    WHERE salary >= 50000;
    
    -- Query 2: Baseline compensation
    SELECT *
    FROM employee_salary
    WHERE salary >= 10000;
END $$
DELIMITER ;

-- Execute multi-statement procedure
CALL get_salary_brackets();

-- 4. Parameterized Stored Procedure
-- Parameters allow stored routines to dynamically accept inputs (IN, OUT, INOUT)
DROP PROCEDURE IF EXISTS get_employee_salary_by_id;

DELIMITER $$
CREATE PROCEDURE get_employee_salary_by_id(IN employee_id_param INT)
BEGIN
    SELECT 
        employee_id,
        first_name,
        last_name,
        occupation,
        salary
    FROM employee_salary
    WHERE employee_id = employee_id_param;
END $$
DELIMITER ;

-- Execute with argument
CALL get_employee_salary_by_id(1);
CALL get_employee_salary_by_id(3);
