# Module 01: SQL Fundamentals

This module covers foundational relational query mechanics in MySQL, focusing on clean syntax, data extraction, and summary statistics.

---

## 📂 Contents

| File | Core Concepts Covered |
| :--- | :--- |
| [`01-select-statements.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/01-sql-fundamentals/01-select-statements.sql) | Column projection, PEMDAS arithmetic expressions, `DISTINCT` unique values |
| [`02-where-group-by-having.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/01-sql-fundamentals/02-where-group-by-having.sql) | Row filtering (`WHERE`), grouping (`GROUP BY`), aggregate filters (`HAVING`), sorting (`ORDER BY`) |
| [`03-limit-and-aliasing.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/01-sql-fundamentals/03-limit-and-aliasing.sql) | Top-N record limiting (`LIMIT`), column renaming (`AS`), alias referencing in `HAVING` |

---

## 💡 Key SQL Insights

### Query Execution Order vs. Syntax Order
SQL queries are written in a specific order, but MySQL processes them in a different logical sequence:
1. `FROM` & `JOIN` (determine data sources)
2. `WHERE` (filter individual rows)
3. `GROUP BY` (aggregate into buckets)
4. `HAVING` (filter aggregated groups)
5. `SELECT` (evaluate expressions & apply aliases)
6. `DISTINCT` (eliminate duplicate rows)
7. `ORDER BY` (sort the final set)
8. `LIMIT` (truncate output)

Understanding this execution order is critical for writing efficient queries and avoiding logical bugs (such as using aliases in `WHERE` clauses).
