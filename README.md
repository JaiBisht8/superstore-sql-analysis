# Superstore Sales Analysis (SQL Project)

## Overview
This project analyzes the Superstore sales dataset using SQL to answer real business questions — the kind of questions a data analyst would be asked to solve. The goal was to go from raw data to clean, business-ready insights entirely using SQL: aggregation, CASE statements, subqueries, window functions, and CTEs.

## Dataset
- **Source:** Superstore Sales Dataset (Kaggle)
- **Rows:** 9,800
- **Columns:** Order ID, Order Date, Ship Date, Ship Mode, Customer Name, Segment, Country, City, State, Postal Code, Region, Product ID, Category, Sub-Category, Product Name, Sales

## Tools Used
- MySQL (database + queries)
- Excel (data cleaning, dashboard — see `/excel` folder)

## Data Cleaning
Before analysis, the raw CSV needed cleaning:
- Removed embedded double-quote characters in product names (e.g. `72"H`) that were breaking CSV parsing
- Filled missing Postal Code values
- Converted `Order Date` from text to a proper `DATE` type for time-based analysis

## Questions Answered

| # | Question | SQL Concept Used |
|---|----------|-------------------|
| 1 | What is the total sales overall? | Aggregation (SUM) |
| 2 | What are total sales by region? | GROUP BY |
| 3 | What are total sales by category? | GROUP BY |
| 4 | What are the top 5 sub-categories by sales? | GROUP BY, ORDER BY, LIMIT |
| 5 | What is the year-wise sales trend? | Date functions |
| 6 | Who are the top 10 customers by sales value? | GROUP BY, ORDER BY, LIMIT |
| 7 | How do orders break down by size (Small/Medium/Large)? | CASE statement |
| 8 | How many orders are above the average sales value? | Subquery |
| 9 | What are the top 3 sub-categories within each region? | Window function (RANK, PARTITION BY) |
| 10 | What is the month-wise running total of sales for 2018? | Window function (running total) |
| 11 | Which customers have placed more than 5 orders? | CTE |

## Key Insights
- **Total sales:** ₹22.6 lakh across 9,800 orders.
- **Region:** West leads (₹7.1L), followed closely by East. South is the weakest region — a potential area for growth focus.
- **Category:** Technology, Furniture, and Office Supplies are close in revenue, with Technology slightly ahead — the business isn't over-reliant on one category.
- **Top products:** Phones and Chairs are the top-selling sub-categories in *every* region, showing consistent nationwide demand.
- **Trend:** Sales have grown year over year, with a strong jump from 2017 to 2018 and a seasonal spike in Q4 (Oct–Dec).
- **Customers:** The highest-spending customer (by value) and the most frequent customer (by order count) are different people — high-value and high-frequency customers need different retention strategies.
- **Order sizes:** Nearly half of all orders are small (under ₹50 in sales), but large orders likely drive a disproportionate share of revenue.

## Files
- `superstore_analysis.sql` — all 11 queries with comments
- `/excel/` — dashboard built from the same dataset (pivot tables, charts)

## What I'd Explore Next
- Profit and discount analysis (not available in this trimmed dataset)
- Customer segmentation based on order frequency and value
- Shipping time analysis (Order Date vs Ship Date)
