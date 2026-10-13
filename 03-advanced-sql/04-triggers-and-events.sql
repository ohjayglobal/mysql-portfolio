-- =====================================================================
-- Module 03: Advanced SQL
-- Script: 04-triggers-and-events.sql
-- Description: Automated Database Event triggers (AFTER INSERT, NEW alias) 
--              and Scheduled Background Events (CREATE EVENT).
-- Database: parks_and_recreation
-- =====================================================================

USE parks_and_recreation;

-- Inspect baseline state
SELECT * FROM employee_salary;
SELECT * FROM employee_demographics;

-- 1. Automated TRIGGER: Synchronize Demographics upon Salary Table Insert
-- The trigger executes automatically whenever a new employee row is inserted into employee_salary.
DROP TRIGGER IF EXISTS employee_insert;

DELIMITER $$
CREATE TRIGGER employee_insert
    AFTER INSERT ON employee_salary
    FOR EACH ROW 
BEGIN
    INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

-- Test Trigger Execution:
-- Inserting into employee_salary automatically triggers insertion into employee_demographics
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Ojima', 'Japheth', 'Data Analyst / Researcher', 2000000, 1);

-- Verify demographic table was automatically populated via Trigger
SELECT * 
FROM employee_demographics
WHERE employee_id = 13;

-- 2. SCHEDULED EVENT: Automated Database Maintenance
-- Events execute SQL tasks automatically based on a predefined time schedule.
-- First ensure MySQL event scheduler is enabled:
SET GLOBAL event_scheduler = ON;

DROP EVENT IF EXISTS delete_retirees;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
    DELETE
    FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;

-- Inspect active system variables for MySQL Event Scheduler
SHOW VARIABLES LIKE 'event_scheduler';
