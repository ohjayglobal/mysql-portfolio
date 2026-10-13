# Module 03: Advanced SQL

This module focuses on advanced database engineering, modular analytical architectures, procedural routines, and event-driven automation in MySQL.

---

## 📂 Contents

| File | Core Concepts Covered |
| :--- | :--- |
| [`01-ctes.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/03-advanced-sql/01-ctes.sql) | Common Table Expressions (`WITH`), modular pipeline design, readability optimization |
| [`02-temporary-tables.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/03-advanced-sql/02-temporary-tables.sql) | Session-scoped staging tables, CTAS (`CREATE TABLE AS SELECT`), intermediate ETL stages |
| [`03-stored-procedures.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/03-advanced-sql/03-stored-procedures.sql) | Procedural SQL, `DELIMITER` scoping, `BEGIN...END` blocks, parameterized dynamic procedures |
| [`04-triggers-and-events.sql`](file:///c:/Users/OHJAY-TECH/Downloads/Projects/Training/Data%20Analysis%20course/MySQL/03-advanced-sql/04-triggers-and-events.sql) | Event triggers (`AFTER INSERT`, `NEW`), audit synchronizations, scheduled cron-like background jobs (`CREATE EVENT`) |

---

## 💡 Practical Applications in Data Analytics & Research

- **CTEs (`WITH`)**: Break complex multi-stage analytical queries into readable, testable, and reusable blocks—crucial for transparent research pipelines.
- **Temporary Tables**: Ideal for high-volume data transformation where intermediate calculations need to be materialized and indexed without altering production schemas.
- **Stored Procedures & Triggers**: Automate repeatable data extraction workflows, data validation constraints, and cross-table synchronization pipelines.
