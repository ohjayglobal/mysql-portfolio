-- =====================================================================
-- Sub-Module: Data Standardization & Cleaning
-- Script: 02-standardizing-data.sql
-- Project: World Layoffs Data Cleaning
-- =====================================================================

USE world_layoffs;

-- 1. Trim company names
UPDATE layoffs_staging2
SET company = TRIM(company);

-- 2. Standardize industry names (Group variations under 'Crypto')
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- 3. Standardize country strings (Strip trailing periods)
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- 4. Date formatting and casting to DATE type
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- 5. Impute missing industry values via Self-Join
UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = '';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- 6. Remove completely uninformative records
DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- 7. Drop staging index column
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
