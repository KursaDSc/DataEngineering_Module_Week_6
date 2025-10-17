-- =========================================================
-- 1. USE warehouse and schema
-- =========================================================
USE WAREHOUSE SAKILA_WH;
USE SCHEMA SAKILA.SAKILA_DWH;

-- =========================================================
-- 2. DIM_CUSTOMER
-- =========================================================
CREATE OR REPLACE TABLE DIM_CUSTOMER AS
SELECT 
    c.customer_id,
    c.store_id,
    c.first_name,
    c.last_name,
    c.email,
    c.active,
    c.create_date,
    c.last_update
FROM SAKILA.SAKILA_RAW.RAW_CUSTOMER c;

-- =========================================================
-- 3. DIM_RENTAL
-- =========================================================
CREATE OR REPLACE TABLE DIM_RENTAL AS
SELECT 
    r.rental_id,
    r.inventory_id,
    r.customer_id,
    r.rental_date,
    r.return_date,
    r.staff_id
FROM SAKILA.SAKILA_RAW.RAW_RENTAL r;

-- =========================================================
-- 4. DIM_DATE (Tarih boyutu türetme)
-- =========================================================
CREATE OR REPLACE TABLE DIM_DATE AS
SELECT DISTINCT
    TO_DATE(p.payment_date) AS date,
    YEAR(p.payment_date) AS year,
    MONTH(p.payment_date) AS month,
    DAY(p.payment_date) AS day,
    TO_CHAR(p.payment_date,'DY') AS weekday
FROM SAKILA.SAKILA_RAW.RAW_PAYMENT p;

-- =========================================================
-- 5. FACT_PAYMENT
-- =========================================================
CREATE OR REPLACE TABLE FACT_PAYMENT AS
SELECT 
    p.payment_id,
    p.customer_id,
    p.rental_id,
    p.staff_id,
    p.amount,
    TO_DATE(p.payment_date) AS payment_date,
    d.year,
    d.month
FROM SAKILA.SAKILA_RAW.RAW_PAYMENT p
LEFT JOIN DIM_DATE d
    ON TO_DATE(p.payment_date) = d.date;

-- =========================================================
-- 6. Simple checking queries
-- =========================================================
SELECT COUNT(*) AS customer_count FROM DIM_CUSTOMER;
SELECT COUNT(*) AS payment_count FROM FACT_PAYMENT;
SELECT COUNT(*) AS rental_count FROM DIM_RENTAL;
SELECT COUNT(*) AS date_count FROM DIM_DATE;
