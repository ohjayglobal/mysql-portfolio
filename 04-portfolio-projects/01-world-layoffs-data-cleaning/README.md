# Project 01: World Layoffs Data Cleaning & Standardization

![MySQL](https://img.shields.io/badge/MySQL-8.0+-4479A1?style=flat-square&logo=mysql&logoColor=white)
![ETL](https://img.shields.io/badge/Pipeline-ETL%20Data%20Cleaning-orange?style=flat-square)
![Status](https://img.shields.io/badge/Status-Completed-success?style=flat-square)

---

## 📌 Executive Summary

Raw data collected from real-world events is rarely clean, consistent, or analysis-ready. This project focuses on building a production-grade, step-by-step SQL data cleaning pipeline using **MySQL 8.0** on the **World Layoffs dataset** (tracking tech and corporate workforce reductions globally from 2020 to 2023).

The primary goal of this project was to transform inconsistent, noisy raw data into a reliable, standardized schema suitable for high-impact analytical queries, machine learning, and academic research.

---

## 🛠️ Data Cleaning Framework

The project executes a comprehensive 5-phase data cleaning framework:

```
[Raw Ingestion: layoffs]
          │
          ▼
[Phase 1: Staging Setup] ──> layoffs_staging (Preserve raw audit trail)
          │
          ▼
[Phase 2: Deduplication] ──> ROW_NUMBER() OVER(PARTITION BY all dimensions) in layoffs_staging2
          │
          ▼
[Phase 3: Standardization] ──> Whitespace trimming, category aggregation ('Crypto'), date parsing
          │
          ▼
[Phase 4: Missing Data] ──> Relational imputation via Self-Joins & non-viable record pruning
          │
          ▼
[Phase 5: Schema Cleanup] ──> Column pruning & data type casting (TEXT -> DATE)
```

---

## 🔍 Key Data Cleaning Challenges & SQL Solutions

### 1. Duplicate Detection in MySQL without Native Delete CTE
- **Problem**: Duplicate rows existed across company records with identical dates and headcounts. In MySQL, running a direct `DELETE` statement against a Common Table Expression (CTE) is not permitted.
- **Solution**: Evaluated duplicate rows using `ROW_NUMBER() OVER (PARTITION BY ...)` and created a secondary staging table `layoffs_staging2` with an explicit `row_num` column, enabling targeted deletion of `WHERE row_num > 1`.

### 2. Categorical & Text Inconsistencies
- **Problem**: Inconsistent company spacing (e.g. `'  Company  '`), redundant trailing punctuation (`'United States.'`), and splintered industry categories (`'Crypto'`, `'Crypto Currency'`, `'CryptoCurrency'`).
- **Solution**: Utilized `TRIM()`, `TRIM(TRAILING '.' FROM country)`, and standardized pattern updates:
  ```sql
  UPDATE layoffs_staging2
  SET industry = 'Crypto'
  WHERE industry LIKE 'Crypto%';
  ```

### 3. Date Parsing & Type Casting
- **Problem**: Dates were stored as raw text in `MM/DD/YYYY` string format. String dates cannot be queried efficiently using SQL time-series functions or ordered chronologically.
- **Solution**: Applied `STR_TO_DATE(date, '%m/%d/%Y')` to convert strings to standard ISO date format, followed by `ALTER TABLE ... MODIFY COLUMN date DATE`.

### 4. Handling Missing Data (Blanks vs. Nulls)
- **Problem**: Several records contained blank string `''` values for industry while another record for the same company had the correct industry classification (e.g. Airbnb).
- **Solution**: Converted blanks to `NULL`, then applied a relational **self-join** to impute missing industry labels from existing populated records of the same entity:
  ```sql
  UPDATE layoffs_staging2 t1
  JOIN layoffs_staging2 t2
      ON t1.company = t2.company
  SET t1.industry = t2.industry
  WHERE t1.industry IS NULL
    AND t2.industry IS NOT NULL;
  ```

### 5. Filtering Non-Informative Data
- Records with simultaneous `NULL` values in both `total_laid_off` and `percentage_laid_off` were deleted because they provided no measurable quantitative metrics for downstream economic analysis.

---

## 📂 Project Files

| File | Purpose |
| :--- | :--- |
| [`world_layoffs_data_cleaning.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/04-portfolio-projects/01-world-layoffs-data-cleaning/world_layoffs_data_cleaning.sql) | Complete master cleaning script containing all 5 phases in an executable sequence |
| [`01-removing-duplicates.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/04-portfolio-projects/01-world-layoffs-data-cleaning/01-removing-duplicates.sql) | Focused script dedicated to staging design and window function deduplication |
| [`02-standardizing-data.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/04-portfolio-projects/01-world-layoffs-data-cleaning/02-standardizing-data.sql) | Focused script covering string manipulation, formatting, and imputation |

---

## 📊 Results & Business Impact

- Successfully eliminated 100% of duplicate corporate records.
- Standardized all date records into indexable `DATE` types, enabling granular time-series analysis.
- Cleaned and populated industry records across tech giants (e.g., Airbnb, Carvana, Juul).
- Delivered a clean, validated `layoffs_staging2` dataset ready for Exploratory Data Analysis.
