# SQL (Advanced) Assignment

## 1. Assignment Overview

Advanced SQL tasks in MySQL on the `customers`, `products` and `orders` tables. The tasks cover joins, subqueries, set operations, window functions, CTEs, views, indexes, stored routines, transactions, triggers and performance tuning.

## 2. Database Schema

### Customers

| Column        | Data Type    | Constraints |
|---------------|--------------|-------------|
| customer_id   | INT          | PRIMARY KEY |
| customer_name | VARCHAR(100) | NOT NULL    |
| city          | VARCHAR(50)  |             |
| email         | VARCHAR(100) | UNIQUE      |

### Products

| Column       | Data Type     | Constraints |
|--------------|---------------|-------------|
| product_id   | INT           | PRIMARY KEY |
| product_name | VARCHAR(100)  | NOT NULL    |
| category     | VARCHAR(50)   |             |
| price        | DECIMAL(10,2) | NOT NULL    |

### Orders

| Column      | Data Type | Constraints                       |
|-------------|-----------|-----------------------------------|
| order_id    | INT       | PRIMARY KEY                       |
| customer_id | INT       | NOT NULL, FOREIGN KEY → Customers |
| product_id  | INT       | NOT NULL, FOREIGN KEY → Products  |
| quantity    | INT       | NOT NULL                          |
| order_date  | DATE      | NOT NULL                          |

### Order_Audit (created in Task 19)

| Column      | Data Type | Constraints                 |
|-------------|-----------|-----------------------------|
| audit_id    | INT       | PRIMARY KEY, AUTO_INCREMENT |
| order_id    | INT       |                             |
| customer_id | INT       |                             |
| product_id  | INT       |                             |
| quantity    | INT       |                             |
| order_date  | DATE      |                             |
| logged_at   | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP   |

### Relationships

- `orders.customer_id` references `customers.customer_id`.
- `orders.product_id` references `products.product_id`.

## 3. Steps to Execute the SQL Script

The script creates and selects the `shop` database itself, so it can be run directly.

From the MySQL command line:

```bash
mysql -u <username> -p < sahil_mujawar_advance.sql
```

Or from the MySQL client / Workbench:

```sql
source sahil_mujawar_advance.sql;
```

Execution order inside the script:

| Order | Section                                    | Tasks   |
|-------|--------------------------------------------|---------|
| 1     | Setup (database, tables, sample data)      | –       |
| 2     | Section 1: Advanced Joins                  | 1 – 3   |
| 3     | Section 2: Subqueries                      | 4 – 6   |
| 4     | Section 3: Set Operations                  | 7 – 8   |
| 5     | Section 4: Window Functions                | 9 – 10  |
| 6     | Section 5: CTEs                            | 11 – 12 |
| 7     | Section 6: Views                           | 13      |
| 8     | Section 7: Indexes and Query Performance   | 14 – 15 |
| 9     | Section 8: Stored Procedures and Functions | 16 – 17 |
| 10    | Section 9: Transactions                    | 18      |
| 11    | Section 10: SQL Triggers                   | 19      |
| 12    | Section 11: Performance Tuning             | 20      |