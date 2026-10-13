-- =====================================================================
-- Module 02: Intermediate SQL
-- Script: 03-string-functions.sql
-- Description: Text manipulation functions (LENGTH, UPPER, LOWER, TRIM, 
--              LEFT, RIGHT, SUBSTRING, REPLACE, LOCATE, CONCAT).
-- Database: parks_and_recreation
-- =====================================================================

USE parks_and_recreation;

-- 1. LENGTH: Measure character count of strings
SELECT 
    first_name, 
    LENGTH(first_name) AS name_length
FROM employee_demographics
ORDER BY name_length ASC;

-- 2. Case Conversion: UPPER and LOWER
SELECT 
    first_name, 
    UPPER(first_name) AS upper_name,
    LOWER(first_name) AS lower_name
FROM employee_demographics;

-- 3. Trimming Whitespace: TRIM, LTRIM, RTRIM
SELECT 
    '                DATA ANALYST            ' AS raw_text,
    TRIM('                DATA ANALYST            ') AS trimmed_text,
    LTRIM('                DATA ANALYST            ') AS left_trimmed,
    RTRIM('                DATA ANALYST            ') AS right_trimmed;

-- 4. Substring Extraction: LEFT, RIGHT, and SUBSTRING
-- Extracting month from date strings formatted as YYYY-MM-DD
SELECT 
    first_name,
    LEFT(first_name, 4) AS first_4_chars,
    RIGHT(first_name, 4) AS last_4_chars,
    birth_date,
    SUBSTRING(birth_date, 6, 2) AS birth_month
FROM employee_demographics;

-- 5. Text Substitution: REPLACE
SELECT 
    first_name, 
    REPLACE(first_name, 'a', 'z') AS modified_name
FROM employee_demographics;

-- 6. String Position Matching: LOCATE
-- Finds the 1-indexed position of a character or substring
SELECT 
    LOCATE('p', 'Japheth') AS position_found;

-- 7. String Concatenation: CONCAT
SELECT 
    first_name, 
    last_name, 
    CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;
