# SQL (Basic) Assignment

## 1. Assignment Overview

The SQL script demonstrates the following SQL fundamentals:

- Creating tables and inserting sample data
- Data retrieval using `SELECT`, column aliases, and `DISTINCT`
- Filtering using `WHERE`, `BETWEEN`, and `LIKE`
- Sorting and limiting results using `ORDER BY` and `LIMIT`
- Aggregate functions: `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`
- Grouping using `GROUP BY` and `HAVING`
- Joins: `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`
- Data manipulation using `INSERT`, `UPDATE`, `DELETE`
- Creating a table with constraints: `PRIMARY KEY`, `NOT NULL`, `UNIQUE`

## 2. Database Schema

### Authors

| Column      | Data Type    |
|-------------|--------------|
| author_id   | INT          |
| author_name | VARCHAR(100) |
| country     | VARCHAR(50)  |

### Books

| Column         | Data Type     |
|----------------|---------------|
| book_id        | INT           |
| title          | VARCHAR(100)  |
| author_id      | INT           |
| category       | VARCHAR(50)   |
| price          | DECIMAL(10,2) |
| published_year | INT           |

### Publishers (created in Task 21)

| Column           | Data Type    | Constraints      |
|------------------|--------------|------------------|
| publisher_id     | INT          | PRIMARY KEY      |
| publisher_name   | VARCHAR(100) | NOT NULL, UNIQUE |
| country          | VARCHAR(50)  | NOT NULL         |
| established_year | INT          | NOT NULL         |

### Relationship

`Books.author_id` refers to `Authors.author_id` (one author can have many books).

## 3. Steps to Execute the SQL Script

**Step 1: Create and select a database**

```sql
CREATE DATABASE bookstore;
USE bookstore;
```

**Step 2: Run the SQL script**

From the MySQL command line:

```bash
mysql -u <username> -p bookstore < sahil_mujawar_bookstore.sql
```

from inside the MySQL Workbench:

```sql
SOURCE sahil_mujawar_bookstore.sql;
```

**Step 3: Execution order inside the script**

| Order | Section                                              | Commands executed                                                                        |
|-------|------------------------------------------------------|------------------------------------------------------------------------------------------|
| 1     | Setup                                                | `CREATE TABLE authors`, `CREATE TABLE books`, `INSERT INTO authors`, `INSERT INTO books` |
| 2     | Section 1: Basic Queries (Tasks 1–4)                 | `SELECT`, column aliases, `DISTINCT`                                                     |
| 3     | Section 2: Filtering Data (Tasks 5–9)                | `WHERE`, `BETWEEN`, `LIKE`                                                               |
| 4     | Section 3: Sorting and Limiting (Tasks 10–11)        | `ORDER BY`, `LIMIT`                                                                      |
| 5     | Section 4: Aggregate Functions (Task 12)             | `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`                                                      |
| 6     | Section 5: GROUP BY and HAVING (Tasks 13–14)         | `GROUP BY`, `HAVING`                                                                     |
| 7     | Section 6: Joins (Tasks 15–17)                       | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`                                                  |
| 8     | Section 7: Data Manipulation (Tasks 18–20)           | `INSERT`, `UPDATE`, `DELETE`                                                             |
| 9     | Section 8: Creating Tables and Constraints (Task 21) | `CREATE TABLE Publishers`, `DESC publishers`                                             |
