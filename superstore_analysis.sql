-- ============================================
-- SUPERSTORE SALES ANALYSIS
-- SQL Project by Jai
-- Dataset: Superstore (9800 rows)
-- ============================================

-- Setup: Fixing Order Date column (originally text, converted to DATE type)
ALTER TABLE superstore ADD COLUMN Order_Date_Fixed DATE;
SET SQL_SAFE_UPDATES = 0;
UPDATE superstore 
SET Order_Date_Fixed = STR_TO_DATE(`Order Date`, '%d-%m-%Y');


-- ============================================
-- Q1: What is the total sales overall?
-- ============================================
SELECT SUM(Sales) AS Total_Sales
FROM superstore;


-- ============================================
-- Q2: What are the total sales by region?
-- ============================================
SELECT Region, SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Region
ORDER BY Total_Sales DESC;


-- ============================================
-- Q3: What are the total sales by category?
-- ============================================
SELECT Category, SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;


-- ============================================
-- Q4: What are the top 5 sub-categories by sales?
-- ============================================
SELECT `Sub-Category`, SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY `Sub-Category`
ORDER BY Total_Sales DESC
LIMIT 5;


-- ============================================
-- Q5: What is the year-wise sales trend?
-- ============================================
SELECT YEAR(Order_Date_Fixed) AS Order_Year, SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Order_Year
ORDER BY Order_Year;


-- ============================================
-- Q6: Who are the top 10 customers by sales value?
-- ============================================
SELECT `Customer Name`, SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;


-- ============================================
-- Q7: How do orders break down by size (Small/Medium/Large)?
-- Uses CASE statement to bucket orders
-- ============================================
SELECT 
    CASE 
        WHEN Sales < 50 THEN 'Small'
        WHEN Sales BETWEEN 50 AND 200 THEN 'Medium'
        ELSE 'Large'
    END AS Order_Size,
    COUNT(*) AS Number_of_Orders
FROM superstore
GROUP BY Order_Size
ORDER BY Number_of_Orders DESC;


-- ============================================
-- Q8: How many orders are above the average sales value?
-- Uses a subquery to calculate the average
-- ============================================
SELECT COUNT(*) AS Orders_Above_Average
FROM superstore
WHERE Sales > (SELECT AVG(Sales) FROM superstore);


-- ============================================
-- Q9: What are the top 3 sub-categories within each region?
-- Uses RANK() window function with PARTITION BY
-- ============================================
SELECT Region, `Sub-Category`, Total_Sales, Ranking
FROM (
    SELECT 
        Region, 
        `Sub-Category`, 
        SUM(Sales) AS Total_Sales,
        RANK() OVER (PARTITION BY Region ORDER BY SUM(Sales) DESC) AS Ranking
    FROM superstore
    GROUP BY Region, `Sub-Category`
) AS ranked_data
WHERE Ranking <= 3;


-- ============================================
-- Q10: What is the month-wise running total of sales for 2018?
-- Uses a window function to calculate cumulative sum
-- ============================================
SELECT 
    MONTH(Order_Date_Fixed) AS Order_Month,
    SUM(Sales) AS Monthly_Sales,
    SUM(SUM(Sales)) OVER (ORDER BY MONTH(Order_Date_Fixed)) AS Running_Total
FROM superstore
WHERE YEAR(Order_Date_Fixed) = 2018
GROUP BY Order_Month
ORDER BY Order_Month;


-- ============================================
-- Q11: Which customers have placed more than 5 orders?
-- Uses a CTE (Common Table Expression)
-- ============================================
WITH Customer_Orders AS (
    SELECT `Customer Name`, COUNT(*) AS Order_Count
    FROM superstore
    GROUP BY `Customer Name`
)
SELECT `Customer Name`, Order_Count
FROM Customer_Orders
WHERE Order_Count > 5
ORDER BY Order_Count DESC
LIMIT 10;
