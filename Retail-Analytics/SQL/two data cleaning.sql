-- =====================================================================
-- 02_data_cleaning.sql
-- Builds CLEAN tables from RAW tables. Raw data is never modified.
-- Each decision is documented where it is made.
-- =====================================================================
use project;
-- setup
DROP TABLE IF EXISTS clean_products;
DROP TABLE IF EXISTS clean_customers;
DROP TABLE IF EXISTS clean_sales;


-- ---------- Products ------------------------------------------------
CREATE TABLE clean_products AS  -- creating new table so original table does not get modified
SELECT ProductID,
       ProductName,
       Category,
       StockLevel,
       Price AS CatalogPrice
FROM product_inventory;

select * from customer_profiles;
-- ---------- Customers -----------------------------------------------
-- * Age outside 18-100 -> NULL (customer kept, impossible value removed;
--   we do not guess a replacement).
-- * Missing Location   -> 'Unknown' (explicit category, rows not deleted).
-- * JoinDate dd/mm/yy  -> ISO yyyy-mm-dd so dates sort/compare correctly.
CREATE TABLE clean_customers AS

SELECT
    CustomerID,

    CASE
        WHEN Age BETWEEN 18 AND 100 THEN Age
        ELSE NULL
    END AS Age,

    CASE
        WHEN Age NOT BETWEEN 18 AND 100 THEN NULL
        WHEN Age < 25 THEN '18-24'
        WHEN Age < 35 THEN '25-34'
        WHEN Age < 45 THEN '35-44'
        WHEN Age < 55 THEN '45-54'
        WHEN Age < 65 THEN '55-64'
        ELSE '65+'
    END AS AgeGroup,

    Gender,

    COALESCE(NULLIF(TRIM(Location), ''), '') AS Location,

    CASE
        WHEN STR_TO_DATE(JoinDate, '%d/%m/%y') IS NOT NULL
        THEN DATE_FORMAT(
            STR_TO_DATE(JoinDate, '%d/%m/%y'),
            '%Y-%m-%d'
        )
        ELSE NULL
    END AS JoinDate

FROM customer_profiles;
select * from  clean_customers;
UPDATE clean_customers
SET Location = 'Unknown'
WHERE Location = '';

SET SQL_SAFE_UPDATES = 0;

-- ---------- Sales ---------------------------------------------------
-- * SELECT DISTINCT removes exact duplicate rows.
-- * Unit price = catalog price. Justification: every mismatch is one
--   product at exactly 100x its catalog price (a decimal-shift error),
--   while all other rows match the catalog exactly
-- * RawRevenue is kept so the impact of the correction can be shown.

select *  from  sales_transaction;
-- Step 1: Remove the previous cleaned table if it exists
DROP TABLE IF EXISTS clean_sales;

-- name: cleaning_validation
CREATE TABLE clean_sales AS
SELECT DISTINCT
    s.TransactionID,
    s.CustomerID,
    s.ProductID,
    s.QuantityPurchased,
    s.TransactionDate,

    -- Preserve the original recorded price
    s.Price AS RecordedPrice,

    -- Use the product catalogue price as the unit price
    p.Price AS UnitPrice,

    -- Flag transactions where the recorded price differs
    CASE
        WHEN ABS(s.Price - p.Price) > 0.01 THEN 1
        ELSE 0
    END AS PriceCorrected,

    -- Revenue using the original recorded price
    ROUND(s.QuantityPurchased * s.Price, 2) AS RawRevenue,

    -- Revenue using the catalogue price
    ROUND(s.QuantityPurchased * p.Price, 2) AS Revenue

FROM sales_transaction AS s
INNER JOIN product_inventory AS p
    ON s.ProductID = p.ProductID;
    
    
-- Check the number of cleaned transactions
SELECT COUNT(*) AS total_rows
FROM clean_sales;

-- Check transactions where prices were flagged
SELECT *
FROM clean_sales
WHERE PriceCorrected = 1;

-- Compare revenue before and after correction
SELECT
    ROUND(SUM(RawRevenue), 2) AS TotalRawRevenue,
    ROUND(SUM(Revenue), 2) AS TotalCorrectedRevenue,
    ROUND(SUM(RawRevenue) - SUM(Revenue), 2) AS RevenueDifference
FROM clean_sales;

select * from clean_sales;
-- creating index for each table
CREATE INDEX idx_cs_cust
ON clean_sales(CustomerID);

CREATE INDEX idx_cs_prod
ON clean_sales(ProductID);

CREATE INDEX idx_cs_date
ON clean_sales(TransactionDate);

-- name: cleaning_validation
-- Post-cleaning assertions.
SELECT
    'clean_sales rows (expect 5000)' AS check_name,
    COUNT(*) AS n
FROM clean_sales
-- Check duplicate transaction IDs
UNION ALL
SELECT
    'duplicate TransactionIDs (expect 0)',
    COUNT(*) - COUNT(DISTINCT TransactionID)
FROM clean_sales
-- Count rows with corrected prices
UNION ALL
SELECT
    'rows with price corrected (expect 20)',
    SUM(PriceCorrected)
FROM clean_sales
-- Calculate the revenue difference
UNION ALL
SELECT
    'revenue removed by correction',
    ROUND(SUM(RawRevenue) - SUM(Revenue), 2)
FROM clean_sales
-- Check invalid dates
UNION ALL
SELECT
    'invalid ISO dates (expect 0)',
    COUNT(*)
FROM clean_sales
WHERE DATE(TransactionDate) IS NULL
-- Check customers with missing ages
UNION ALL
SELECT
    'customers with NULL age (expect 1)',
    COUNT(*)
FROM clean_customers
WHERE Age is null;



