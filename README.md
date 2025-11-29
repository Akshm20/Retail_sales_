# Retail_sales_
# 🛍️ Retail Sales Analysis using MySQL  

This project focuses on performing end-to-end **data cleaning**, **exploration**, and **SQL-based analysis** on a retail sales dataset.  
The goal is to derive meaningful business insights using SQL queries in **MySQL Workbench**.

---

## 📁 Project Files

- **poject1_retail_sales.sql** – Complete SQL script containing:
  - Table creation  
  - Data quality checks  
  - NULL handling  
  - Data cleaning  
  - Business analysis queries  
- **SQL - Retail Sales Analysis_utf.csv** – Raw dataset containing transactional retail sales data.

---

## 📊 Dataset Overview

The dataset contains **retail transactions** with the following fields:

| Column | Description |
|--------|-------------|
| `transaction_id` | Unique transaction ID |
| `sale_date` | Date of sale (YYYY-MM-DD) |
| `sale_time` | Time of sale |
| `customer_id` | Unique customer identifier |
| `gender` | Gender of customer |
| `age` | Age of customer |
| `category` | Product category (Clothing, Beauty, Electronics) |
| `quantiy` | Quantity sold |
| `price_per_unit` | Price per item |
| `cogs` | Cost of goods sold |
| `total_sale` | Total sale amount |

Total rows after cleaning: **1997**  
(Originally loaded: **1987** rows)

---

## 🧹 Data Cleaning Steps

Key cleaning operations included:

### ✔ Handling NULL Values  
- Checked for NULLs across all columns  
- Converted blank values to NULL before importing  
- Ensured `age` and `quantiy` columns accept NULL using:
  ```sql
  ALTER TABLE retail_sales MODIFY age INT NULL;
  ALTER TABLE retail_sales MODIFY quantiy INT NULL;

### ✔ Imputing Missing Age Values
Used average age to replace NULLs:
```sql
UPDATE retail_sales
SET age = (
    SELECT avg_age FROM (
        SELECT AVG(age) AS avg_age 
        FROM retail_sales
    ) AS t
)
WHERE age IS NULL;
```

### ✔ Removing Corrupted Rows
Deleted rows where any critical column was NULL:
```sql
DELETE FROM retail_sales
WHERE transaction_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

### ✔ Validating Data Types

- Ensured sale_date was in correct format (YYYY-MM-DD)

- Ensured all numeric fields were correctly parsed

---

 ## 🔍 Data Exploration

### ✔ Total Sales Records
```sql
SELECT COUNT(*) FROM retail_sales;
```
### ✔ Unique Customers
```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```
### ✔ Categories Available
```sql
SELECT DISTINCT category FROM retail_sales;
```

---


## 📘 Business Questions & SQL Answers

### The project answers 10 real-world retail business questions such as:

-  1. Sales on a specific day
-  2. Clothing orders with quantity ≥4 for November 2022
-  3. Total sales by category
-  4. Avg age of Beauty customers
-  5. High-value transactions (>1000 sale)
-  6. Transaction count by gender per category
-  7. Best-selling month in each year (using RANK + CTE)
-  8. Top 5 customers by total sale
-  9. Unique customers by category
-  10. Orders by shift (Morning, Afternoon, Evening)

### All queries are available in poject1_retail_sales.sql.



