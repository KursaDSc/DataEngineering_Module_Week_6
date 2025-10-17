-- =========================================================
-- USE warehouse and schema
-- =========================================================
USE WAREHOUSE SAKILA_WH; 
USE SCHEMA SAKILA.SAKILA_RAW; 

-- =========================================================
-- 1️⃣ RAW_CUSTOMER TABLE 
-- =========================================================
CREATE OR REPLACE TABLE RAW_CUSTOMER (
  customer_id INTEGER,
  store_id INTEGER,
  first_name STRING,
  last_name STRING,
  email STRING,
  address_id INTEGER,
  active BOOLEAN,
  create_date TIMESTAMP,
  last_update TIMESTAMP
);

COPY INTO RAW_CUSTOMER
FROM @SAKILA.SAKILA_RAW.SAKILA_STAGE/customer.csv
FILE_FORMAT = (TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER = 1);

-- =========================================================
-- 2️⃣ RAW_PAYMENT TABLE
-- =========================================================
CREATE OR REPLACE TABLE RAW_PAYMENT (
  payment_id INTEGER,
  customer_id INTEGER,
  staff_id INTEGER,
  rental_id INTEGER,
  amount FLOAT,
  payment_date TIMESTAMP,
  last_update TIMESTAMP
  
);

COPY INTO RAW_PAYMENT
FROM @SAKILA.SAKILA_RAW.SAKILA_STAGE/payment.csv
FILE_FORMAT = (TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER = 1);

-- =========================================================
-- 3️⃣ RAW_RENTAL TABLE
-- =========================================================
CREATE OR REPLACE TABLE RAW_RENTAL (
  rental_id INTEGER,
  rental_date TIMESTAMP,
  inventory_id INTEGER,
  customer_id INTEGER,
  return_date TIMESTAMP,
  staff_id INTEGER,
  last_update TIMESTAMP
);

COPY INTO RAW_RENTAL
FROM @SAKILA.SAKILA_RAW.SAKILA_STAGE/rental.csv
FILE_FORMAT = (TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER = 1);

-- =========================================================
-- 4️⃣ Get loaded row counts
-- =========================================================
SELECT COUNT(*) AS customer_rows FROM RAW_CUSTOMER;
SELECT COUNT(*) AS payment_rows FROM RAW_PAYMENT;
SELECT COUNT(*) AS rental_rows FROM RAW_RENTAL;