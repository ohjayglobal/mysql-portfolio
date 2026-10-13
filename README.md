# SQL Data Analytics & Research Portfolio

[![MySQL](https://img.shields.io/badge/MySQL-8.0+-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![SQL](https://img.shields.io/badge/Language-SQL-CC292B?style=for-the-badge&logo=sqlite&logoColor=white)](#)
[![Data Analysis](https://img.shields.io/badge/Field-Data%20Analytics%20%26%20Research-00599C?style=for-the-badge)](#)
[![Portfolio](https://img.shields.io/badge/Portfolio-Production%20Ready-success?style=for-the-badge)](#)

---

## 👨‍💻 About the Author

**Salifu Ojima Japheth** (Ojima Japheth)  
*Data Analyst & Researcher*  
Combining academic research rigor and publication experience with advanced relational database engineering and exploratory data analysis. This portfolio showcases production SQL proficiencies across data extraction, ETL pipelines, data cleaning, statistical aggregation, and time-series business insights.

---

## 🧭 Repository Architecture

```
sql-data-analytics-portfolio/
│
├── 01-sql-fundamentals/                    # Core Relational Query Mechanics
│   ├── 01-select-statements.sql            # SELECT, arithmetic projections, DISTINCT
│   ├── 02-where-group-by-having.sql        # WHERE, GROUP BY, aggregates, HAVING, ORDER BY
│   ├── 03-limit-and-aliasing.sql           # Top-N LIMIT, alias referencing
│   └── README.md
│
├── 02-intermediate-sql/                    # Relational Modeling & Transformations
│   ├── 01-joins.sql                        # INNER, LEFT, RIGHT, and multi-table joins
│   ├── 02-unions.sql                       # UNION sets & custom segment labeling
│   ├── 03-string-functions.sql             # Text parsing, regex patterns, TRIM, SUBSTRING
│   ├── 04-case-statements.sql              # Conditional branching & tiered calculations
│   ├── 05-subqueries.sql                   # Scalar, derived, and correlated subqueries
│   ├── 06-window-functions.sql             # OVER(), PARTITION BY, ROW_NUMBER, RANK, DENSE_RANK
│   └── README.md
│
├── 03-advanced-sql/                        # Database Engineering & Automation
│   ├── 01-ctes.sql                         # Single and multi-level Common Table Expressions
│   ├── 02-temporary-tables.sql             # Session-scoped staging tables & CTAS
│   ├── 03-stored-procedures.sql            # Procedural routines, DELIMITER, input parameters
│   ├── 04-triggers-and-events.sql          # Automated AFTER INSERT triggers & scheduled events
│   └── README.md
│
├── 04-portfolio-projects/                  # End-to-End Real-World Analytics Projects
│   ├── 01-world-layoffs-data-cleaning/     # Master Data Cleaning Pipeline (Layoffs Dataset)
│   │   ├── world_layoffs_data_cleaning.sql # Full 5-phase data cleaning pipeline
│   │   ├── 01-removing-duplicates.sql      # Dedicated deduplication via Window Functions
│   │   ├── 02-standardizing-data.sql       # Normalization, string formatting, self-join imputation
│   │   └── README.md                       # Comprehensive methodology & documentation
│   │
│   └── 02-world-layoffs-exploratory-analysis/ # Macroeconomic Exploratory Data Analysis
│       ├── world_layoffs_exploratory_analysis.sql # Rolling totals, multi-level ranking CTEs
│       └── README.md                       # Research questions, insights, and findings
│
└── data/                                   # Datasets & Database Schema Seeds
    ├── sample_data/
    │   └── layoffs.csv                     # Raw global layoffs dataset (2020 - 2023)
    ├── setup_scripts/
    │   └── parks_and_recreation_db_setup.sql # Schema & seed script for tutorial modules
    └── README.md
```

---

## 🚀 Featured Portfolio Projects

### 🧹 [Project 1: World Layoffs Data Cleaning & Standardization](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/04-portfolio-projects/01-world-layoffs-data-cleaning/README.md)
* **Objective**: Transform a noisy, inconsistent dataset of global layoffs (2020–2023) into an analysis-ready relational schema.
* **Key Techniques**:
  * Staging table architecture to preserve raw source data.
  * Duplicate identification and deletion using `ROW_NUMBER() OVER (PARTITION BY ...)` and a secondary staging index.
  * Standardizing categorical entries (`'Crypto%'`), removing invalid trailing punctuation (`'United States.'`), and trimming whitespace.
  * Parsing string dates (`MM/DD/YYYY`) into ISO standard format (`YYYY-MM-DD`) and casting to native `DATE` datatypes.
  * Relational self-joins to impute missing industry classifications from existing company records.
  * Schema optimization and pruning of non-viable records.

---

### 📈 [Project 2: World Layoffs Exploratory Data Analysis (EDA)](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/04-portfolio-projects/02-world-layoffs-exploratory-analysis/README.md)
* **Objective**: Conduct macroeconomic and corporate workforce contraction analysis across tech and commercial industries.
* **Key Techniques**:
  * Identification of outlier events and 100% shutdown incidents ranked by fundraising capital.
  * Time-series monthly trajectory and cumulative **rolling sum** analysis using window functions.
  * Multi-level CTE ranking using `DENSE_RANK() OVER (PARTITION BY year ORDER BY total_laid_off DESC)` to isolate the top 5 layoff events per calendar year.
* **Key Findings**:
  * Pandemic-era hiring surges led to concentrated enterprise workforce corrections in late 2022 and early 2023 (e.g., Amazon, Google, Meta, Microsoft).
  * High-burn venture-backed startups exhibited heightened vulnerability during monetary tightening, leading to total liquidations.

---

## 🛠️ Technical Competency Matrix

| Category | Skills & SQL Syntax |
| :--- | :--- |
| **Data Querying & Filtering** | `SELECT`, `WHERE`, `DISTINCT`, `LIKE`, `IN`, `BETWEEN`, `ORDER BY`, `LIMIT` |
| **Aggregations & Grouping** | `GROUP BY`, `HAVING`, `SUM()`, `AVG()`, `COUNT()`, `MIN()`, `MAX()` |
| **Relational Operations** | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL JOIN`, `CROSS JOIN`, `UNION`, `UNION ALL` |
| **String & Date Manipulation** | `CONCAT()`, `SUBSTRING()`, `TRIM()`, `REPLACE()`, `LOCATE()`, `STR_TO_DATE()`, `DATE` casting |
| **Conditional Business Logic** | `CASE WHEN ... THEN ... ELSE ... END`, `IFNULL()`, `COALESCE()` |
| **Analytical Window Functions** | `OVER()`, `PARTITION BY`, `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, rolling sums |
| **Advanced Query Design** | Common Table Expressions (CTEs), Subqueries (scalar & derived), Temp Tables |
| **Database Engineering** | Stored Procedures (`DELIMITER`, `BEGIN...END`, parameters), Triggers (`AFTER INSERT`), Scheduled Events |

---

## 💻 How to Replicate and Run Locally

### 1. Prerequisites
- [MySQL Server 8.0+](https://dev.mysql.com/downloads/mysql/) installed locally or via Docker.
- A database client such as [MySQL Workbench](https://www.mysql.com/products/workbench/), DBeaver, or VS Code Database extension.

### 2. Setup the Sample Database
To run the SQL scripts in Modules 01, 02, and 03:
1. Open [`data/setup_scripts/parks_and_recreation_db_setup.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/data/setup_scripts/parks_and_recreation_db_setup.sql).
2. Execute the entire script to create and seed the `Parks_and_Recreation` database.

### 3. Setup the Portfolio Projects
1. Create a database named `world_layoffs`:
   ```sql
   CREATE DATABASE world_layoffs;
   USE world_layoffs;
   ```
2. Import [`data/sample_data/layoffs.csv`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/data/sample_data/layoffs.csv) into table `layoffs` via MySQL Workbench Table Data Import Wizard or `LOAD DATA INFILE`.
3. Execute [`04-portfolio-projects/01-world-layoffs-data-cleaning/world_layoffs_data_cleaning.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/04-portfolio-projects/01-world-layoffs-data-cleaning/world_layoffs_data_cleaning.sql) to generate the clean `layoffs_staging2` table.
4. Execute [`04-portfolio-projects/02-world-layoffs-exploratory-analysis/world_layoffs_exploratory_analysis.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/04-portfolio-projects/02-world-layoffs-exploratory-analysis/world_layoffs_exploratory_analysis.sql) to run the exploratory insights queries.

---

## 📚 Publications & Research Background

As a data analyst and researcher with peer-reviewed publications:
- Applied rigorous methodologies to ensure data reproducibility, audit trails, and schema integrity.
- Maintained strict separation between raw observation data and downstream transformed staging layers.
- Focused on empirical evidence extraction, hypothesis testing, and quantitative reporting.

---

## 📬 Contact & Connect

- **GitHub**: [github.com/ohjayglobal](https://github.com/ohjayglobal)
- **Repository**: [github.com/ohjayglobal/mysql-portfolio](https://github.com/ohjayglobal/mysql-portfolio)
- **LinkedIn**: [linkedin.com](https://www.linkedin.com/)