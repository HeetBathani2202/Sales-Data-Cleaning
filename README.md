# Sales Data Cleaning 

Cleaning a messy 1,004-row sales dataset using SQL in PostgreSQL / pgAdmin 4.

## Problems found
- 4 exact duplicate rows
- 51 invalid dates (2024-02-30) and dates in mixed formats
- Missing prices, categories, payment methods, delivery status
- Inconsistent payment labels (CC, creditcard, credit)
- Negative quantities; totals that didn't match price × quantity

## Results
Rows before: 1,004 → after: 1,000

## How to run
1. Create the table and import data/sales.csv (CSV format, header on)
2. Run sql/sales_cleaning.sql top to bottom

## Tools
PostgreSQL 18, pgAdmin 4
