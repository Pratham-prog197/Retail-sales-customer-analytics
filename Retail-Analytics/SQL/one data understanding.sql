create database project;
use project ;
-- =====================================================================
-- 01_data_quality_checks.sql
-- Goal: audit the RAW tables BEFORE touching anything.
-- =====================================================================

RENAME TABLE `customer_profiles-1-1714027410` TO customer_profiles;      -- Renamed Table and irregular column names
select * from customer_profiles;
ALTER TABLE customer_profiles RENAME COLUMN `ï»¿CustomerID` TO customerID;

RENAME TABLE `product_inventory-1-1714027438` TO product_inventory;
select * from product_inventory;
ALTER TABLE product_inventory RENAME COLUMN `ï»¿ProductID` TO ProductID;

RENAME TABLE `sales_transaction-1714027462 (1)` TO Sales_transaction;
select * from Sales_transaction;
ALTER TABLE Sales_transaction RENAME COLUMN `ï»¿TransactionID` TO TransactionID;
-- counting number of rows 
select count(*) from customer_profiles;
select count(*) from product_inventory;
select count(*) from Sales_transaction;

-- 1) Exact duplicate transaction rows (same ID + same values)
SELECT 'ISSUE: duplicate sales rows' AS issue,
       (SELECT COUNT(*) FROM customer_profiles)
       -
       (SELECT COUNT(*)
        FROM (SELECT DISTINCT * FROM customer_profiles) AS t) AS duplicate_rows;
        
SELECT 'ISSUE: duplicate product rows' AS issue,
       (SELECT COUNT(*) FROM product_inventory)
       -
       (SELECT COUNT(*)
        FROM (SELECT DISTINCT * FROM product_inventory) AS t) AS duplicate_rows;
        
SELECT 'ISSUE: duplicate transaction rows' AS issue,
       (SELECT COUNT(*) FROM sales_transaction)
       -
       (SELECT COUNT(*)
        FROM (SELECT DISTINCT * FROM sales_transaction) AS t) AS duplicate_rows;
-- sales transaction has 2 duplicate rows

-- 2) Recorded price differs from the catalog price of that product
 SELECT 'ISSUE: sales price != catalog price',
       COUNT(*) FROM sales_transaction as s JOIN product_inventory p USING (ProductID)
       WHERE ABS(s.Price - p.Price) > 0.01;
       
-- 3) Missing customer location
SELECT 'ISSUE: customers with missing Location',
       COUNT(*) FROM customer_profiles WHERE Location = '';
       
-- 4) Impossible ages (outside 18-100)
SELECT 'ISSUE: customers with impossible Age',
       COUNT(*) FROM customer_profiles WHERE Age < 18 OR Age > 100;
       
-- 5) Referential integrity (orphan foreign keys)
SELECT 'check: sales with unknown CustomerID',
       COUNT(*) FROM sales_transaction s LEFT JOIN customer_profiles c USING (CustomerID) WHERE c.CustomerID IS NULL
UNION ALL
SELECT 'check: sales with unknown ProductID',
       COUNT(*) FROM sales_transaction s LEFT JOIN product_inventory p USING (ProductID) WHERE p.ProductID IS NULL;

-- 6) Non-positive quantities / price
 SELECT 'check: non-positive quantity or price',
       COUNT(*) FROM sales_transaction WHERE QuantityPurchased <= 0 OR Price <= 0 ; 

-- 7) Products out of stock

select * FROM product_inventory
where stockLevel = 0;

-- 8) Which products carry the price mismatch, and by what factor?
SELECT s.ProductID,
       COUNT(*)                          AS affected_rows,
       MIN(s.Price)                      AS recorded_price,
       p.Price                           AS catalog_price,
       ROUND(MIN(s.Price) / p.Price, 2)  AS ratio
FROM sales_transaction s JOIN product_inventory p USING (ProductID)
WHERE ABS(s.Price - p.Price) > 0.01
GROUP BY s.ProductID, p.Price;

-- Evidence that the catalog is the reliable source: for every OTHER row
-- the recorded price matches the catalog exactly.
SELECT COUNT(*) AS rows_matching_catalog
FROM sales_transaction  s JOIN product_inventory p USING (ProductID)
WHERE ABS(s.Price - p.Price) <= 0.01;
