# Module 02: Intermediate SQL

This module advances into relational data modeling, cross-table queries, text parsing, business logic rules, and analytical window functions.

---

## 📂 Contents

| File | Core Concepts Covered |
| :--- | :--- |
| [`01-joins.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/02-intermediate-sql/01-joins.sql) | Relational connections (`INNER`, `LEFT`, `RIGHT`), composite matching, multi-table joins |
| [`02-unions.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/02-intermediate-sql/02-unions.sql) | Vertical dataset consolidation (`UNION`), deduplication rules, and segment labeling |
| [`03-string-functions.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/02-intermediate-sql/03-string-functions.sql) | Text normalization: `LENGTH`, `UPPER`/`LOWER`, `TRIM`, `SUBSTRING`, `REPLACE`, `LOCATE`, `CONCAT` |
| [`04-case-statements.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/02-intermediate-sql/04-case-statements.sql) | Conditional branching (`CASE WHEN THEN ELSE END`), demographic bins, incentive calculations |
| [`05-subqueries.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/02-intermediate-sql/05-subqueries.sql) | Correlated & uncorrelated subqueries, `IN` filters, scalar projections, and derived tables |
| [`06-window-functions.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/02-intermediate-sql/06-window-functions.sql) | Analytical windows: `OVER()`, `PARTITION BY`, rolling aggregations, `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()` |

---

## 💡 Window Functions: Key Differentiators

Unlike traditional `GROUP BY` aggregates that collapse individual records into summary rows, **Window Functions** compute aggregate metrics across partitions while **retaining all underlying detail rows**.

- **`ROW_NUMBER()`**: Generates a continuous unique incrementing integer (`1, 2, 3, 4...`), indispensable for deduplication.
- **`RANK()`**: Assigns identical ranks to ties but skips subsequent rank numbers (`1, 2, 2, 4...`).
- **`DENSE_RANK()`**: Assigns identical ranks to ties without skipping subsequent integers (`1, 2, 2, 3...`), ideal for Top-N leaderboards.
