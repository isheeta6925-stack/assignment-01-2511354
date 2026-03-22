-- ============================================================
-- Part 3 — Data Warehouse: Star Schema
-- Source: retail_transactions.csv
-- ============================================================

-- Drop tables in reverse FK dependency order
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_date;

-- ============================================================
-- DIMENSION TABLE: dim_date
-- Stores one row per calendar date with all time attributes
-- needed for monthly, quarterly, and yearly aggregations.
-- ============================================================
CREATE TABLE dim_date (
    date_key     INT          NOT NULL,   -- surrogate key format: YYYYMMDD
    full_date    DATE         NOT NULL,
    day_of_week  VARCHAR(10)  NOT NULL,
    day_number   INT          NOT NULL,
    month_number INT          NOT NULL,
    month_name   VARCHAR(20)  NOT NULL,
    quarter      INT          NOT NULL,
    year         INT          NOT NULL,
    CONSTRAINT pk_dim_date PRIMARY KEY (date_key)
);

-- ============================================================
-- DIMENSION TABLE: dim_store
-- Stores one row per physical store location.
-- store_region groups cities for regional reporting.
-- ============================================================
CREATE TABLE dim_store (
    store_key    INT          NOT NULL AUTO_INCREMENT,
    store_name   VARCHAR(100) NOT NULL,
    store_city   VARCHAR(100) NOT NULL,
    store_region VARCHAR(50)  NOT NULL,
    CONSTRAINT pk_dim_store PRIMARY KEY (store_key)
);

-- ============================================================
-- DIMENSION TABLE: dim_product
-- Stores one row per product with category and list price.
-- unit_price here is the catalogue price at time of load;
-- the actual transaction price is recorded in fact_sales.
-- ============================================================
CREATE TABLE dim_product (
    product_key  INT           NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(100)  NOT NULL,
    category     VARCHAR(100)  NOT NULL,
    unit_price   DECIMAL(12,2) NOT NULL,
    CONSTRAINT pk_dim_product PRIMARY KEY (product_key)
);

-- ============================================================
-- FACT TABLE: fact_sales
-- One row per retail transaction.
-- Numeric measures: units_sold, unit_price, total_revenue.
-- All descriptive context lives in the dimension tables.
-- ============================================================
CREATE TABLE fact_sales (
    sales_key      INT           NOT NULL AUTO_INCREMENT,
    date_key       INT           NOT NULL,
    store_key      INT           NOT NULL,
    product_key    INT           NOT NULL,
    transaction_id VARCHAR(20)   NOT NULL,
    customer_id    VARCHAR(20)   NOT NULL,
    units_sold     INT           NOT NULL,
    unit_price     DECIMAL(12,2) NOT NULL,
    total_revenue  DECIMAL(14,2) NOT NULL,  -- units_sold * unit_price, pre-computed
    CONSTRAINT pk_fact_sales  PRIMARY KEY (sales_key),
    CONSTRAINT fk_fs_date     FOREIGN KEY (date_key)    REFERENCES dim_date(date_key),
    CONSTRAINT fk_fs_store    FOREIGN KEY (store_key)   REFERENCES dim_store(store_key),
    CONSTRAINT fk_fs_product  FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);

-- ============================================================
-- INSERT DATA — dim_date
-- ETL: All three inconsistent date formats from the source CSV
-- (DD/MM/YYYY, DD-MM-YYYY, YYYY-MM-DD) were normalized to
-- YYYY-MM-DD before generating the YYYYMMDD integer key.
-- ============================================================
INSERT INTO dim_date (date_key, full_date, day_of_week, day_number, month_number, month_name, quarter, year) VALUES
    (20230115, '2023-01-15', 'Sunday',    15,  1, 'January',  1, 2023),
    (20230205, '2023-02-05', 'Sunday',     5,  2, 'February', 1, 2023),
    (20230220, '2023-02-20', 'Monday',    20,  2, 'February', 1, 2023),
    (20230331, '2023-03-31', 'Friday',    31,  3, 'March',    1, 2023),
    (20230604, '2023-06-04', 'Sunday',     4,  6, 'June',     2, 2023),
    (20230809, '2023-08-09', 'Wednesday',  9,  8, 'August',   3, 2023),
    (20230815, '2023-08-15', 'Tuesday',   15,  8, 'August',   3, 2023),
    (20230829, '2023-08-29', 'Tuesday',   29,  8, 'August',   3, 2023),
    (20231020, '2023-10-20', 'Friday',    20, 10, 'October',  4, 2023),
    (20231026, '2023-10-26', 'Thursday',  26, 10, 'October',  4, 2023),
    (20231208, '2023-12-08', 'Friday',     8, 12, 'December', 4, 2023),
    (20231212, '2023-12-12', 'Tuesday',   12, 12, 'December', 4, 2023);

-- ============================================================
-- INSERT DATA — dim_store
-- ETL: 19 rows in the source had NULL store_city. The correct
-- city was inferred from store_name and applied before loading.
-- ============================================================
INSERT INTO dim_store (store_key, store_name, store_city, store_region) VALUES
    (1, 'Chennai Anna',   'Chennai',   'South'),
    (2, 'Delhi South',    'Delhi',     'North'),
    (3, 'Bangalore MG',   'Bangalore', 'South'),
    (4, 'Pune FC Road',   'Pune',      'West'),
    (5, 'Mumbai Central', 'Mumbai',    'West');

-- ============================================================
-- INSERT DATA — dim_product
-- ETL: Source categories had inconsistent casing (electronics,
-- Electronics) and naming (Grocery vs Groceries). All values
-- were title-cased and 'Grocery' was standardized to 'Groceries'.
-- ============================================================
INSERT INTO dim_product (product_key, product_name, category, unit_price) VALUES
    (1,  'Speaker',    'Electronics', 49262.78),
    (2,  'Tablet',     'Electronics', 23226.12),
    (3,  'Phone',      'Electronics', 48703.39),
    (4,  'Smartwatch', 'Electronics', 58851.01),
    (5,  'Atta 10kg',  'Groceries',   52464.00),
    (6,  'Jeans',      'Clothing',     2317.47),
    (7,  'Biscuits',   'Groceries',   27469.99),
    (8,  'Jacket',     'Clothing',    30187.24),
    (9,  'Laptop',     'Electronics', 42343.15),
    (10, 'Milk 1L',    'Groceries',   43374.39),
    (11, 'Headphones', 'Electronics', 15000.00),
    (12, 'Saree',      'Clothing',    12500.00),
    (13, 'T-Shirt',    'Clothing',     1800.00),
    (14, 'Rice 5kg',   'Groceries',    4500.00),
    (15, 'Oil 1L',     'Groceries',    2200.00),
    (16, 'Pulses 1kg', 'Groceries',    1800.00);

-- ============================================================
-- INSERT DATA — fact_sales (12 cleaned rows from source CSV)
-- total_revenue = units_sold * unit_price, pre-computed at load
-- =======================================================
