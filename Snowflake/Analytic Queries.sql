USE WAREHOUSE SAKILA_WH;
USE SCHEMA SAKILA.SAKILA_DWH;

-- =========================================================
-- 1. Monthly Revenue Calculation
-- Objective: Calculates the total revenue (SUM(AMOUNT)) for
--            each year and month by joining FACT_PAYMENT to DIM_DATE.
-- =========================================================
SELECT
    dd.YEAR,
    dd.MONTH,
    SUM(fp.AMOUNT) AS monthly_revenue
FROM
    FACT_PAYMENT fp
JOIN
    DIM_DATE dd ON fp.PAYMENT_DATE = dd.DATE
GROUP BY
    dd.YEAR,
    dd.MONTH
ORDER BY
    dd.YEAR,
    dd.MONTH;

---
-- =========================================================
-- 2. Top Customers by Revenue
-- Objective: Lists the top 10 customers (first and last name)
--            based on their highest total spending (total_spending).
--            (Does not require DIM_DATE join).
-- =========================================================
SELECT
    dc.FIRST_NAME,
    dc.LAST_NAME,
    SUM(fp.AMOUNT) AS total_spending
FROM
    FACT_PAYMENT fp
JOIN
    DIM_CUSTOMER dc ON fp.CUSTOMER_ID = dc.CUSTOMER_ID
GROUP BY
    dc.CUSTOMER_ID, dc.FIRST_NAME, dc.LAST_NAME
ORDER BY
    total_spending DESC
LIMIT 10;

---
-- =========================================================
-- 3. Monthly Average Payment Trend
-- Objective: Shows the trend of the average transaction size
--            (AVG(AMOUNT)) over time by joining FACT_PAYMENT to DIM_DATE.
-- =========================================================
SELECT
    dd.YEAR,
    dd.MONTH,
    AVG(fp.AMOUNT) AS average_payment_amount
FROM
    FACT_PAYMENT fp
JOIN
    DIM_DATE dd ON fp.PAYMENT_DATE = dd.DATE
GROUP BY
    dd.YEAR,
    dd.MONTH
ORDER BY
    dd.YEAR,
    dd.MONTH;