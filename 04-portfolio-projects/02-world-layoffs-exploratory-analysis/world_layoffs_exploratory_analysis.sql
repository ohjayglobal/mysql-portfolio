-- =====================================================================
-- Portfolio Project 02: World Layoffs Exploratory Data Analysis (EDA)
-- Author: Salifu Ojima Japheth (Data Analyst & Researcher)
-- Database Engine: MySQL 8.0+
-- Dataset: Global Tech & Corporate Layoffs (Cleaned Staging Table)
--
-- RESEARCH & ANALYTICAL QUESTIONS:
-- 1. What are the maximum layoff thresholds and total closure incidents?
-- 2. Which companies and industries suffered the heaviest workforce cuts?
-- 3. What is the chronological progression of layoffs on a yearly and monthly basis?
-- 4. How does the cumulative rolling total of global layoffs evolve over time?
-- 5. Who were the top 5 companies laying off employees in each individual year?
-- =====================================================================

USE world_layoffs;

-- 1. Baseline Overview & Range of Metrics
-- Identifies extreme values in layoffs and percentage of staff dismissed
SELECT 
    MAX(total_laid_off) AS max_single_layoff_event, 
    MAX(percentage_laid_off) AS max_percentage_laid_off
FROM layoffs_staging2;

-- 2. Complete Shutdowns (100% Layoffs) Ranked by Capital Raised
-- Companies that laid off 100% of staff (percentage_laid_off = 1) sorted by funding
SELECT 
    company,
    location,
    industry,
    funds_raised_millions,
    `date`
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- 3. Total Workforce Reductions by Company
-- Aggregate total layoffs to identify the most heavily impacted organizations
SELECT 
    company, 
    SUM(total_laid_off) AS total_employees_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY total_employees_laid_off DESC
LIMIT 10;

-- 4. Total Workforce Reductions by Industry Sector
SELECT 
    industry, 
    SUM(total_laid_off) AS total_employees_laid_off
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_employees_laid_off DESC;

-- 5. Total Workforce Reductions by Country
SELECT 
    country, 
    SUM(total_laid_off) AS total_employees_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY total_employees_laid_off DESC
LIMIT 10;

-- 6. Year-over-Year (YoY) Macro Trend Analysis
SELECT 
    YEAR(`date`) AS layoff_year, 
    SUM(total_laid_off) AS total_employees_laid_off
FROM layoffs_staging2
WHERE YEAR(`date`) IS NOT NULL
GROUP BY YEAR(`date`)
ORDER BY layoff_year DESC;

-- 7. Monthly Layoff Progression
SELECT 
    SUBSTRING(`date`, 1, 7) AS `month`, 
    SUM(total_laid_off) AS monthly_layoffs
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY `month` ASC;

-- 8. Cumulative Rolling Total Calculation (Time-Series Window Function)
-- Calculates how global layoffs accumulated month-over-month
WITH monthly_layoffs_cte AS (
    SELECT 
        SUBSTRING(`date`, 1, 7) AS `month`, 
        SUM(total_laid_off) AS total_off
    FROM layoffs_staging2
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `month`
    ORDER BY `month` ASC
)
SELECT 
    `month`, 
    total_off AS monthly_layoffs,
    SUM(total_off) OVER(ORDER BY `month`) AS rolling_total_layoffs
FROM monthly_layoffs_cte;

-- 9. Layoffs by Company and Year
SELECT 
    company, 
    YEAR(`date`) AS `year`, 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY company ASC;

-- 10. Multi-Level Ranking: Top 5 Companies with Highest Layoffs Per Year
-- Combines multiple CTEs with DENSE_RANK() window function partitioned by year
WITH Company_Year AS (
    SELECT 
        company, 
        YEAR(`date`) AS `years`, 
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
),
Company_Year_Rank AS (
    SELECT 
        company, 
        years, 
        total_laid_off,
        DENSE_RANK() OVER(
            PARTITION BY years 
            ORDER BY total_laid_off DESC
        ) AS ranking
    FROM Company_Year
    WHERE years IS NOT NULL
)
SELECT 
    company, 
    years, 
    total_laid_off, 
    ranking
FROM Company_Year_Rank
WHERE ranking <= 5
ORDER BY years DESC, ranking ASC;
