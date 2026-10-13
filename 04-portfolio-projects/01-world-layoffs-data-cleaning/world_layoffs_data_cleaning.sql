-- =====================================================================
-- Portfolio Project 01: World Layoffs Data Cleaning & Standardization
-- Author: Salifu Ojima Japheth (Data Analyst & Researcher)
-- Database Engine: MySQL 8.0+
-- Dataset: Global Tech & Corporate Layoffs (2020 - 2023)
-- 
-- PROJECT OBJECTIVES & METHODOLOGY:
-- 1. Create robust Staging Tables to preserve raw historical data.
-- 2. Identify and eliminate Duplicate Records using Window Functions (ROW_NUMBER).
-- 3. Standardize text strings, categorical labels, country nomenclature, and date formats.
-- 4. Handle Null and Blank values via relational imputation (self-joins) and filtering.
-- 5. Prune non-informative records and drop intermediate ETL helper columns.
-- =====================================================================

-- Step 0: Database Selection & Initial Exploration
CREATE DATABASE IF NOT EXISTS world_layoffs;
USE world_layoffs;

-- Inspect raw ingested dataset
SELECT * 
FROM layoffs;

-- =====================================================================
-- PHASE 1: STAGING ENVIRONMENT CREATION
-- Best practice in data analysis & research: Never alter raw source data directly.
-- =====================================================================

DROP TABLE IF EXISTS layoffs_staging;

CREATE TABLE layoffs_staging 
LIKE layoffs;

INSERT INTO layoffs_staging
SELECT * 
FROM layoffs;

SELECT * 
FROM layoffs_staging;

-- =====================================================================
-- PHASE 2: DUPLICATE DETECTION & REMOVAL
-- MySQL does not allow direct DELETE from a CTE updating the target table,
-- so we employ a secondary staging table with an explicit row_num index.
-- =====================================================================

-- Identify duplicates by partitioning across all key attributes
WITH duplicate_cte AS (
    SELECT *, 
        ROW_NUMBER() OVER(
            PARTITION BY 
                company, 
                location, 
                industry, 
                total_laid_off, 
                percentage_laid_off, 
                `date`, 
                stage, 
                country, 
                funds_raised_millions
        ) AS row_num
    FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

-- Create persistent staging table including row_num for safe pruning
DROP TABLE IF EXISTS layoffs_staging2;

CREATE TABLE `layoffs_staging2` (
    `company` TEXT,
    `location` TEXT,
    `industry` TEXT,
    `total_laid_off` INT DEFAULT NULL,
    `percentage_laid_off` TEXT,
    `date` TEXT,
    `stage` TEXT,
    `country` TEXT,
    `funds_raised_millions` INT DEFAULT NULL,
    `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Populate layoffs_staging2 with calculated row numbers
INSERT INTO layoffs_staging2
SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY 
            company, 
            location, 
            industry, 
            total_laid_off, 
            percentage_laid_off, 
            `date`, 
            stage, 
            country, 
            funds_raised_millions
    ) AS row_num
FROM layoffs_staging;

-- Verify duplicate records in staging2 (row_num > 1)
SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- Permanently remove identified duplicates
DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- Verify all remaining records have unique identifier row_num = 1
SELECT COUNT(*) AS count_of_records
FROM layoffs_staging2
WHERE row_num > 1;

-- =====================================================================
-- PHASE 3: DATA STANDARDIZATION
-- Standardizing whitespace, unifying categorical labels, fixing trailing 
-- punctuation, and transforming date strings to true SQL DATE types.
-- =====================================================================

-- 1. Trim redundant leading/trailing whitespace from company names
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

-- 2. Standardize Industry Categories (e.g., Unify 'Crypto', 'Crypto Currency', 'CryptoCurrency')
SELECT DISTINCT industry 
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- 3. Standardize Country Names (e.g., removing trailing period from 'United States.')
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- 4. Date Format Normalization & Datatype Conversion
-- Convert raw string dates formatted as 'MM/DD/YYYY' to MySQL standard 'YYYY-MM-DD'
SELECT 
    `date`,
    STR_TO_DATE(`date`, '%m/%d/%Y') AS converted_date
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- Convert column datatype from TEXT to native DATE
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- =====================================================================
-- PHASE 4: NULL & BLANK VALUES IMPUTATION
-- Handling missing values through relational self-joins where company 
-- metadata exists on other records.
-- =====================================================================

-- 1. Convert blank string representations in industry to true NULL
UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = '';

-- 2. Inspect missing industry rows where another row has the populated industry
SELECT 
    t1.company, 
    t1.industry AS missing_industry, 
    t2.industry AS reference_industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- 3. Impute missing industry values using self-join
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- 4. Identify non-viable records lacking core analytical metrics
-- Records where both total_laid_off AND percentage_laid_off are completely missing
SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- Remove non-viable records that cannot be imputed and offer no analytical value
DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- =====================================================================
-- PHASE 5: SCHEMA OPTIMIZATION & CLEANUP
-- =====================================================================

-- Drop intermediate ETL helper column
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- Final verification of clean dataset
SELECT * 
FROM layoffs_staging2
LIMIT 20;

SELECT COUNT(*) AS total_clean_records
FROM layoffs_staging2;
