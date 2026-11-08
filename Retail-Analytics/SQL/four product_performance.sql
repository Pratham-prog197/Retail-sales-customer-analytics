-- =====================================================================
-- 04_product_performance.sql
-- Objective: identify high- and low-sales products to optimise
-- inventory and focus marketing.
-- =====================================================================
use project;
-- setup
CREATE OR REPLACE VIEW product_perf AS

WITH days AS (
    SELECT
        DATEDIFF(
            MAX(TransactionDate),
            MIN(TransactionDate)
        ) + 1 AS n
    FROM clean_sales
),

base AS (
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,
        p.CatalogPrice AS Price,
        p.StockLevel,

        COALESCE(SUM(s.QuantityPurchased), 0) AS Units,
        COALESCE(SUM(s.Revenue), 0) AS Revenue,
        COUNT(s.TransactionID) AS Transactions,
        COUNT(DISTINCT s.CustomerID) AS UniqueBuyers

    FROM clean_products p
    LEFT JOIN clean_sales s
        ON p.ProductID = s.ProductID

    GROUP BY
        p.ProductID,
        p.ProductName,
        p.Category,
        p.CatalogPrice,
        p.StockLevel
),

ranked AS (
    SELECT
        *,

        RANK() OVER (
            ORDER BY Revenue DESC
        ) AS RevenueRank,

        NTILE(4) OVER (
            ORDER BY Revenue DESC, ProductID
        ) AS RevenueQuartile,

        NTILE(4) OVER (
            ORDER BY StockLevel DESC, ProductID
        ) AS StockQuartile,

        (
            SUM(Revenue) OVER (
                ORDER BY Revenue DESC, ProductID
                ROWS BETWEEN UNBOUNDED PRECEDING
                         AND 1 PRECEDING
            )
        ) / NULLIF(SUM(Revenue) OVER (), 0) AS CumShareBefore,

        (
            SUM(Revenue) OVER (
                ORDER BY Revenue DESC, ProductID
                ROWS BETWEEN UNBOUNDED PRECEDING
                         AND CURRENT ROW
            )
        ) / NULLIF(SUM(Revenue) OVER (), 0) AS CumShare

    FROM base
)

SELECT
    r.*,

    CASE
        WHEN COALESCE(CumShareBefore, 0) < 0.80 THEN 'A'
        WHEN CumShareBefore < 0.95 THEN 'B'
        ELSE 'C'
    END AS ABCClass,

    CASE RevenueQuartile
        WHEN 1 THEN 'High'
        WHEN 4 THEN 'Low'
        ELSE 'Mid'
    END AS PerformanceTier,

    ROUND(
        Units / NULLIF((SELECT n FROM days), 0),
        3
    ) AS UnitsPerDay,

    CASE
        WHEN Units = 0 THEN NULL
        WHEN StockLevel = 0 THEN 0
        ELSE ROUND(
            StockLevel /
            NULLIF(
                Units / NULLIF((SELECT n FROM days), 0),
                0
            ),
            0
        )
    END AS DaysOfCover,

    CASE
        WHEN StockLevel = 0
            THEN 'Out of stock'

        WHEN Units > 0
             AND StockLevel /
                 NULLIF(
                     Units / NULLIF((SELECT n FROM days), 0),
                     0
                 ) < 90
            THEN 'Restock now (<90 days of cover)'

        WHEN RevenueQuartile = 4
             AND StockQuartile = 1
            THEN 'Overstock (weak seller, high stock)'

        ELSE 'Balanced'
    END AS InventoryFlag

FROM ranked r;



-- name: product_performance_full
SELECT ProductID, ProductName, Category, Price, StockLevel, Units, Revenue, Transactions,
       UniqueBuyers, RevenueRank, ABCClass, PerformanceTier, UnitsPerDay, DaysOfCover, InventoryFlag
FROM product_perf
ORDER BY RevenueRank;

-- name: top10_products
SELECT RevenueRank, ProductName, Category, Price, Units, ROUND(Revenue, 2) AS Revenue, StockLevel, InventoryFlag
FROM product_perf ORDER BY RevenueRank LIMIT 10;

-- name: bottom10_products
SELECT RevenueRank, ProductName, Category, Price, Units, ROUND(Revenue, 2) AS Revenue, StockLevel, InventoryFlag
FROM product_perf ORDER BY RevenueRank DESC LIMIT 10;

-- name: abc_summary
SELECT ABCClass,
       COUNT(*)                                                           AS products,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM product_perf), 1)   AS pct_of_products,
       ROUND(SUM(Revenue), 2)                                             AS revenue,
       ROUND(100.0 * SUM(Revenue) / (SELECT SUM(Revenue) FROM product_perf), 1) AS pct_of_revenue
FROM product_perf GROUP BY ABCClass ORDER BY ABCClass;

-- name: inventory_flag_summary
SELECT InventoryFlag, COUNT(*) AS products,
       SUM(StockLevel) AS units_in_stock,
       ROUND(SUM(Revenue), 2) AS revenue
FROM product_perf GROUP BY InventoryFlag ORDER BY products DESC;

-- name: restock_priority_list
SELECT ProductID, ProductName, Category, Price, StockLevel, Units, ROUND(Revenue,2) AS Revenue, DaysOfCover
FROM product_perf WHERE InventoryFlag LIKE 'Restock%' OR InventoryFlag = 'Out of stock' ORDER BY DaysOfCover;

-- name: overstock_list
SELECT ProductID, ProductName, Category, Price, StockLevel, Units, ROUND(Revenue,2) AS Revenue, DaysOfCover
FROM product_perf WHERE InventoryFlag LIKE 'Overstock%' ORDER BY StockLevel DESC;

-- name: category_performance
-- Does revenue differ by category because of volume (units) or price?
SELECT Category,
       COUNT(*)                         AS products,
       SUM(Units)                       AS units,
       ROUND(SUM(Revenue), 2)           AS revenue,
       ROUND(AVG(Price), 2)             AS avg_price,
       ROUND(AVG(Units), 1)             AS avg_units_per_product,
       ROUND(AVG(Revenue), 2)           AS avg_revenue_per_product,
       SUM(CASE WHEN PerformanceTier = 'High' THEN 1 ELSE 0 END) AS high_tier_products,
       SUM(CASE WHEN PerformanceTier = 'Low'  THEN 1 ELSE 0 END) AS low_tier_products,
       SUM(StockLevel)                  AS stock_units
FROM product_perf GROUP BY Category ORDER BY revenue DESC;


-- name: product_half_split
-- Used in Python to test whether product rankings are STABLE over time:
-- revenue per product in the first vs. second part of the period.
SELECT ProductID,
       ROUND(SUM(CASE WHEN TransactionDate <  '2023-05-01' THEN Revenue ELSE 0 END), 2) AS revenue_h1,
       ROUND(SUM(CASE WHEN TransactionDate >= '2023-05-01' THEN Revenue ELSE 0 END), 2) AS revenue_h2,
       SUM(CASE WHEN TransactionDate <  '2023-05-01' THEN QuantityPurchased ELSE 0 END) AS units_h1,
       SUM(CASE WHEN TransactionDate >= '2023-05-01' THEN QuantityPurchased else 0 END) AS units_h2
FROM clean_sales GROUP BY ProductID;