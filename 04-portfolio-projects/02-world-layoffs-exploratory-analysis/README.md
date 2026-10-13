# Project 02: World Layoffs Exploratory Data Analysis (EDA)

![MySQL](https://img.shields.io/badge/MySQL-8.0+-4479A1?style=flat-square&logo=mysql&logoColor=white)
![Analysis](https://img.shields.io/badge/Analysis-Exploratory%20Data%20Analysis-blue?style=flat-square)
![Techniques](https://img.shields.io/badge/Techniques-CTEs%20%7C%20Window%20Functions-purple?style=flat-square)

---

## 📌 Executive Summary

Following the comprehensive data cleaning process, this project investigates macroeconomic and corporate workforce contraction patterns across global industries between **2020 and 2023**.

Using advanced analytical SQL patterns—including **multi-level Common Table Expressions (CTEs)**, **cumulative rolling window functions**, and **dense partition ranking**—this analysis provides evidence-based answers to key business and research questions surrounding layoff velocity, industry vulnerability, and top affected enterprises.

---

## 🎯 Key Analytical & Research Questions

1. **Outlier & Peak Impact**: What were the single largest layoff events and which venture-backed startups experienced complete shutdowns (100% staff reductions)?
2. **Enterprise Impact**: Which major corporations laid off the greatest total volume of personnel over the surveyed window?
3. **Temporal Dynamics**: How did layoffs evolve month-over-month, and what was the global cumulative rolling trajectory?
4. **Year-by-Year Benchmarking**: Who were the top 5 companies executing layoffs in each calendar year?

---

## 🔬 Analytical Methodologies & SQL Patterns

### 1. Cumulative Rolling Metrics via Window Aggregations
To understand the macroeconomic compounding effect of tech layoffs over time, a rolling window aggregation was built on top of monthly grouped aggregates:
```sql
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
```

### 2. Multi-Stage Yearly Ranking with `DENSE_RANK()`
To track market leadership in staff reductions dynamically across calendar years without hardcoded date filters:
```sql
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
SELECT *
FROM Company_Year_Rank
WHERE ranking <= 5
ORDER BY years DESC, ranking ASC;
```

---

## 📈 Key Findings & Insights

- **Concentration in Large Tech**: Enterprise tech giants (including Amazon, Google, Meta, and Microsoft) accounted for the largest aggregate headcount cuts, largely clustered in late 2022 and early 2023 following pandemic-era overhiring.
- **Venture Capital Contraction**: Startups with high capital fundraising (hundreds of millions raised in Series B–D) suffered sudden 100% layoffs, highlighting vulnerability in high-burn tech business models during rising interest rate cycles.
- **Sector Vulnerability**: Consumer tech, Retail, and Transportation were among the earliest hit in 2020, whereas Enterprise Software and FinTech bore the brunt of reductions in 2022–2023.

---

## 📂 Project Files

| File | Purpose |
| :--- | :--- |
| [`world_layoffs_exploratory_analysis.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/04-portfolio-projects/02-world-layoffs-exploratory-analysis/world_layoffs_exploratory_analysis.sql) | Comprehensive SQL analysis script featuring rolling totals, group aggregations, and yearly ranking CTEs |
