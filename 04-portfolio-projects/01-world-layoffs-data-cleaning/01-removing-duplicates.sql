-- =====================================================================
-- Sub-Module: Duplicate Detection & Removal
-- Script: 01-removing-duplicates.sql
-- Project: World Layoffs Data Cleaning
-- =====================================================================

USE world_layoffs;

-- 1. Create initial staging table to protect raw dataset
CREATE TABLE IF NOT EXISTS layoffs_staging LIKE layoffs;
INSERT INTO layoffs_staging SELECT * FROM layoffs;

-- 2. CTE Duplicate Identification via Window Function
WITH duplicate_cte AS (
    SELECT *, 
        ROW_NUMBER() OVER(
            PARTITION BY company, location, industry, total_laid_off, 
                         percentage_laid_off, `date`, stage, country, funds_raised_millions
        ) AS row_num
    FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

-- 3. Staging 2 Creation with row_num column
CREATE TABLE IF NOT EXISTS `layoffs_staging2` (
    `company` text,
    `location` text,
    `industry` text,
    `total_laid_off` int DEFAULT NULL,
    `percentage_laid_off` text,
    `date` text,
    `stage` text,
    `country` text,
    `funds_raised_millions` int DEFAULT NULL,
    `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY company, location, industry, total_laid_off, 
                     percentage_laid_off, `date`, stage, country, funds_raised_millions
    ) AS row_num
FROM layoffs_staging;

-- 4. Delete Duplicate Rows (row_num > 1)
DELETE FROM layoffs_staging2
WHERE row_num > 1;
