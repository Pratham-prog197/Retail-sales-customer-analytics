-- =====================================================================
-- 03_eda.sql  -  Exploratory data analysis on the CLEAN tables
-- =====================================================================
use project ;

select * from  clean_sales;
-- name: eda_overview
SELECT COUNT(*)                                        AS transactions,
       SUM(QuantityPurchased)                                   AS units_sold,
       ROUND(SUM(Revenue), 2)                          AS total_revenue,
       ROUND(SUM(Revenue) * 1.0 / COUNT(*), 2)         AS avg_revenue_per_transaction,
       ROUND(AVG(QuantityPurchased), 2)                         AS avg_units_per_transaction,
       COUNT(DISTINCT CustomerID)                      AS purchasing_customers,
       (SELECT COUNT(*) FROM clean_customers)          AS total_customers,
       COUNT(DISTINCT ProductID)                       AS products_sold,
       MIN(TransactionDate)                            AS first_date,
       MAX(TransactionDate)                            AS last_date,
       CAST(
    DATEDIFF(
        MAX(TransactionDate),
        MIN(TransactionDate)
    ) + 1 AS DECIMAL(10,2)
) AS days_observed
FROM clean_sales;

select * from clean_products;
-- name: eda_revenue_by_category
SELECT p.Category,
       COUNT(DISTINCT p.ProductID)                              AS products,
       SUM(s.QuantityPurchased)                                          AS units_sold,
       ROUND(SUM(s.Revenue), 2)                                 AS revenue,
       ROUND(100.0 * SUM(s.Revenue) / (SELECT SUM(Revenue) FROM clean_sales), 1) AS revenue_share_pct,
       ROUND(AVG(s.UnitPrice), 2)                               AS avg_price_per_sale,
       ROUND(SUM(s.Revenue) / COUNT(DISTINCT p.ProductID), 2)   AS revenue_per_product
FROM clean_sales s JOIN clean_products p USING (ProductID)
GROUP BY p.Category
ORDER BY revenue DESC;


-- name: eda_date_range_check
SELECT
    MIN(TransactionDate) AS earliest_date,
    MAX(TransactionDate) AS latest_date,
    COUNT(*) AS total_rows
FROM clean_sales;

UPDATE clean_sales
SET TransactionDate = STR_TO_DATE(TransactionDate, '%d/%m/%y');

-- name: eda_monthly_trend

WITH flagged AS (
    SELECT
        *,
        CASE
            WHEN DATE(TransactionDate) < (
                SELECT MAX(DATE(TransactionDate))
                FROM clean_sales
            )
            THEN 1
            ELSE 0
        END AS complete_day
    FROM clean_sales
)

SELECT
    DATE_FORMAT(TransactionDate, '%Y-%m') AS month,

    COUNT(DISTINCT CASE
        WHEN complete_day = 1 THEN DATE(TransactionDate)
    END) AS complete_days,

    COUNT(*) AS transactions,

    SUM(QuantityPurchased) AS units,

    ROUND(SUM(Revenue), 2) AS revenue,

    ROUND(
        SUM(CASE
            WHEN complete_day = 1 THEN Revenue
            ELSE 0
        END)
        / NULLIF(
            COUNT(DISTINCT CASE
                WHEN complete_day = 1 THEN DATE(TransactionDate)
            END),
            0
        ),
        2
    ) AS revenue_per_day,

    ROUND(
        SUM(CASE
            WHEN complete_day = 1 THEN 1
            ELSE 0
        END)
        / NULLIF(
            COUNT(DISTINCT CASE
                WHEN complete_day = 1 THEN DATE(TransactionDate)
            END),
            0
        ),
        2
    ) AS transactions_per_day,

    COUNT(DISTINCT CustomerID) AS active_customers

FROM flagged
GROUP BY DATE_FORMAT(TransactionDate, '%Y-%m')
ORDER BY month;

-- name: eda_daily_revenue
SELECT TransactionDate AS date,
       COUNT(*)        AS transactions,
       ROUND(SUM(Revenue), 2) AS revenue,
       CASE WHEN TransactionDate < (SELECT MAX(TransactionDate) FROM clean_sales) THEN 1 ELSE 0 END AS complete_day
FROM clean_sales GROUP BY TransactionDate ORDER BY TransactionDate;


-- name: eda_weekday

SELECT
    CASE DAYOFWEEK(TransactionDate)
        WHEN 1 THEN '7-Sun'
        WHEN 2 THEN '1-Mon'
        WHEN 3 THEN '2-Tue'
        WHEN 4 THEN '3-Wed'
        WHEN 5 THEN '4-Thu'
        WHEN 6 THEN '5-Fri'
        WHEN 7 THEN '6-Sat'
    END AS Weekday,

    COUNT(*) AS transactions,

    ROUND(SUM(Revenue), 2) AS Revenue

FROM clean_sales

GROUP BY weekday
ORDER BY weekday;


-- name: eda_customer_demographics
SELECT 'Gender' AS dimension, Gender AS value, COUNT(*) AS customers FROM clean_customers GROUP BY Gender;
-- name: eda_customer_demographics_location
SELECT 'Location', Location, COUNT(*) FROM clean_customers GROUP BY Location;
-- name: eda_customer_demographics_age_group
SELECT 'AgeGroup', COALESCE(AgeGroup, 'Unknown') as Age_group, COUNT(*)  as Total_Customers FROM clean_customers GROUP BY AgeGroup;
-- name: eda_impact_of_price_correction
-- How wrong would the "top products" list be if we had NOT cleaned?
SELECT ProductID,
       ROUND(SUM(RawRevenue), 2)  AS revenue_uncleaned,
       ROUND(SUM(Revenue), 2)     AS revenue_cleaned,
       RANK() OVER (ORDER BY SUM(RawRevenue) DESC) AS rank_uncleaned,
       RANK() OVER (ORDER BY SUM(Revenue) DESC)    AS rank_cleaned
FROM clean_sales
GROUP BY ProductID
ORDER BY revenue_uncleaned DESC
LIMIT 10;

select * from clean_sales;


-- name: purchase_frequency_distribution
WITH customer_frequency AS (
    SELECT
        CustomerID,
        COUNT(DISTINCT TransactionID) AS purchase_count
    FROM clean_sales
    GROUP BY CustomerID
)
SELECT
    CASE
        WHEN purchase_count = 1 THEN '1 purchase'
        WHEN purchase_count = 2 THEN '2 purchases'
        WHEN purchase_count BETWEEN 3 AND 5 THEN '3-5 purchases'
        ELSE '6+ purchases'
    END AS purchase_frequency,
    COUNT(*) AS customer_count,
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM customer_frequency),
        2
    ) AS customer_percentage
FROM customer_frequency
GROUP BY purchase_frequency
ORDER BY MIN(purchase_count);

-- name: average_order_value
SELECT
    COUNT(DISTINCT TransactionID) AS total_transactions,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    ROUND(
        SUM(Revenue) /
        NULLIF(COUNT(DISTINCT TransactionID), 0),
        2
    ) AS average_order_value
FROM clean_sales;

-- name: customer_revenue_concentration

WITH customer_revenue AS (
    SELECT
        CustomerID,
        SUM(Revenue) AS total_spending
    FROM clean_sales
    GROUP BY CustomerID
),

ranked_customers AS (
    SELECT
        CustomerID,
        total_spending,
        ROW_NUMBER() OVER (
            ORDER BY total_spending DESC, CustomerID
        ) AS customer_rank,
        COUNT(*) OVER () AS total_customers
    FROM customer_revenue
)


SELECT
    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN customer_rank <= CEIL(total_customers * 0.10)
            THEN total_spending
            ELSE 0
        END
    ) AS top_10_percent_revenue,

    ROUND(SUM(total_spending), 2) AS total_revenue,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN customer_rank <= CEIL(total_customers * 0.10)
                THEN total_spending
                ELSE 0
            END
        ) / NULLIF(SUM(total_spending), 0),
        2
    ) AS top_10_percent_revenue_share

FROM ranked_customers;