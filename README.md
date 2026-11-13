# 🛒 Retail Sales, Product Performance & Customer Analytics

## 🚀 End-to-End Data Analytics Project | SQL • Python • Power BI
retail analytics project focused on understanding sales performance, product profitability, inventory efficiency, and customer purchasing behaviour using **MySQL, Python, and Power BI**.

The project transforms raw retail data into structured analytical datasets, extracts actionable business insights, and presents the findings through interactive dashboards.

---

## 📈1. Project Overview

Retail businesses generate large amounts of transactional, customer, and product data. However, raw data alone does not provide the insights needed to make effective business decisions.

This project analyses retail sales transactions alongside customer profiles and product inventory to understand:

- Which products and categories contribute the most revenue?
- How does sales performance change over time?
- Which products require restocking or have excess inventory?
- Who are the most valuable customers?
- Which customers are at risk of becoming inactive?
- How can customer purchasing patterns help improve retention and revenue?

The project covers the complete data analytics lifecycle, including data exploration, data cleaning, data transformation, exploratory data analysis (EDA), product performance analysis, customer segmentation, statistical analysis and business intelligence reporting.

The ultimate goal is to help retail businesses make data-driven decisions, improve inventory efficiency, identify revenue opportunities and strengthen customer retention

## ❔2. Why I Chose This Project

I selected retail analytics because retail businesses generate large volumes of transactional, customer and inventory data, but the real challenge lies in converting that information into meaningful business decisions.

I wanted to work on a practical business problem that went beyond basic sales reporting and involved multiple dimensions of business performance.

Retail analytics provided an opportunity to investigate important business challenges, including:

- Identifying products and categories that generate the highest revenue.
- Detecting pricing inconsistencies that can distort financial reporting.
- Understanding inventory shortages and excess stock.
- Identifying high-value customers and customers at risk of disengagement.
- Analysing repeat purchasing patterns and customer retention.
- Translating analytical findings into actionable business recommendations.

I also chose this project to demonstrate my ability to work across the complete analytics lifecycle using SQL for data management and analysis, Python for statistical exploration and Power BI for interactive business reporting.

## 🤔3. Business Problem

The retail business operates with three major sources of information:

1. Sales transactions containing purchase dates, customers, products, quantities and prices.
2. Customer profiles containing demographic and customer information.
3. Product inventory containing product categories, catalogue prices and available stock levels.

The business needs a consolidated understanding of its sales, products, inventory, and customers.

Without structured analysis, management may struggle to identify high-performing products, detect inventory risks, recognise valuable customers, and understand changes in purchasing behaviour.

**The objective is to convert disconnected retail datasets into a reliable analytical foundation that supports better sales planning, inventory management, and customer engagement decisions.**

## 🎯4. Project Objectives

The project was designed around the following objectives:

1. **Improve Data Quality:** Identify and resolve duplicate records, inconsistent prices, invalid values and missing information.
2. **Analyse Sales Performance:** Evaluate revenue, transaction volume, product performance and category-level trends.
3. **Evaluate Product Performance:** Identify high-performing and low-performing products using revenue and quantity-based analysis.
4. **Optimise Inventory:** Identify products requiring restocking, products with excess stock and products with potential inventory risks.
5. **Segment Customers:** Apply RFM analysis to classify customers based on purchasing behaviour and monetary contribution.
6. **Understand Customer Behaviour:** Analyse repeat purchases, purchase frequency, customer retention and inter-purchase intervals.
7. **Perform Statistical Analysis:** Investigate relationships and differences in customer and product performance using statistical techniques.
8. **Build Interactive Dashboards:** Develop Power BI dashboards that communicate important KPIs, trends and business recommendations.

## 📦5. Dataset Description

The project uses three interconnected datasets.

| Dataset | Records | Description |
|---|---:|---|
| Sales Transactions | 5,002 raw rows | Transaction-level sales information |
| Customer Profiles | 1,000 rows | Customer demographics and registration information |
| Product Inventory | 200 rows | Product details, categories, prices, and stock levels |

### Dataset fields

**Sales Transactions**
- `TransactionID`
- `CustomerID`
- `ProductID`
- `QuantityPurchased`
- `TransactionDate`
- `Price`

**Customer Profiles**
- `CustomerID`
- `Age`
- `Gender`
- `Location`
- `JoinDate`

**Product Inventory**
- `ProductID`
- `ProductName`
- `Category`
- `StockLevel`
- `Price`

The datasets are connected through `CustomerID` and `ProductID`, allowing customer-level and product-level analysis.

## 🛠️6. Technology Stack

| Technology | Purpose |
|---|---|
| MySQL | Data cleaning, transformation, analysis, and business queries |
| Python | Exploratory analysis, statistical testing, and visualisation |
| Pandas & NumPy | Data manipulation and numerical analysis |
| Matplotlib & Seaborn | Exploratory data visualisation |
| SciPy | Statistical hypothesis testing |
| Scikit-learn | Feature scaling and customer clustering |
| Power BI | Interactive dashboards and business reporting |
| Excel / CSV | Data inspection and analytical exports |
| Jupyter Notebook | Python development and documentation |

## 🧹 7. Data Cleaning & Preparation

Data quality was treated as an important part of the analytical workflow. Before generating business insights, the raw datasets were inspected for inconsistencies and validation issues.

### Key data quality issues identified

- Duplicate sales transactions.
- Incorrect transaction prices compared with the product catalogue.
- Missing or invalid customer information.
- Inconsistent customer attributes.
- Potentially invalid quantity and price values.
- Data type and date-format inconsistencies.

### Cleaning operations

**Sales data**
- Removed exact duplicate transaction records.
- Validated transaction prices against the product catalogue.
- Corrected identified pricing discrepancies using catalogue prices.
- Preserved original and corrected revenue for comparison.
- Created a price-correction indicator.
- Calculated revenue using quantity multiplied by the validated unit price.

**Customer data**
- Validated customer age values.
- Standardised customer location values.
- Handled blank or unknown demographic information.
- Created age-group classifications for customer analysis.

**Product data**
- Validated product identifiers and catalogue prices.
- Standardised product information.
- Prepared stock and category attributes for inventory analysis.

### Final cleaned datasets

| Table | Records |
|---|---:|
| `clean_sales` | 5,000 |
| `clean_customers` | 1,000 |
| `clean_products` | 200 |

The cleaned tables were used as the foundation for subsequent SQL analysis and Power BI reporting.

## 7. SQL Analysis

SQL was the primary analytical tool used to transform the cleaned datasets into business-ready outputs.

The work was organised into six analytical stages.

### Stage 1 — Data Understanding & Quality Assessment

### Activities Performed

- Inspected table structures and data types.
- Analysed record counts and duplicate records.
- Checked missing and invalid values.
- Validated relationships between sales, customers, and products.
- Compared transaction prices with catalogue prices.
- Identified potential data quality issues before cleaning.

**Business value:** Established the reliability of the underlying datasets before analysis.

### Stage 2 — Data Cleaning & Transformation

### Activities Performed

- Created `clean_sales`, `clean_customers` and `clean_products`.
- Removed exact duplicate sales records.
- Corrected inconsistent transaction prices.
- Calculated corrected revenue.
- Retained original revenue for comparison.
- Created a price-correction flag.
- Standardised customer age groups and locations.
- Standardised transaction and customer dates.
- Created indexes on important join and filter columns.
- Performed post-cleaning validation.

**Key Result:** Reduced the raw sales dataset from 5,002 rows to 5,000 cleaned records.
**Business value:** Established consistent datasets for accurate reporting and analysis.

### Stage 3 — Sales Performance Analysis

**Objective:** Understand overall business performance and identify revenue patterns.

### Activities Performed

- Calculated total revenue and transaction volume.
- Analysed total units sold and purchasing customers.
- Calculated average revenue per transaction.
- Analysed revenue by product category.
- Generated monthly revenue trends.
- Examined daily revenue patterns.
- Compared units sold and revenue across categories.
- Calculated category revenue contribution.

### Important Finding

Home & Kitchen was the highest-revenue category, contributing approximately 31% of total revenue.

**Business value:** Helped identify revenue trends, category contributions, and overall sales performance.

### Stage 4 — Product Performance & Inventory Analysis

**Objective:** Identify high-performing products, low-performing products and inventory risks.

### Activities Performed

- Created a product performance view using aggregated sales data.
- Calculated product revenue, units sold and transaction counts.
- Ranked products using `RANK()`.
- Divided products into quartiles using `NTILE()`.
- Calculated cumulative revenue contribution using window functions.
- Implemented ABC product classification.
- Created product performance tiers.
- Calculated sales velocity and inventory cover.
- Classified inventory into Balanced, Restock, Overstock and Out of Stock categories.
- Generated Top 10 and Bottom 10 product lists.

### ABC Classification

| Class | Products | Revenue Contribution |
|:---:|:---:|:---:|
| A | 118 | 80.4% |
| B | 47 | 14.7% |
| C | 35 | 4.9% |

**Key Finding:** Class A products represent 59% of the product catalogue and contribute approximately 80.4% of revenue.

**Business value:** Helped distinguish high-value products from low-performing products and identify potential inventory management priorities.

### Stage 5 — Customer Segmentation Using RFM Analysis

Implemented RFM analysis to understand customer value and purchasing activity

**Objective:** Understand customer value and classify customers according to purchasing behaviour.

RFM analysis was implemented using:

- **Recency:** Days since the customer's last purchase.
- **Frequency:** Number of transactions made by the customer.
- **Monetary:** Total revenue generated by the customer.

### SQL Techniques Used

- Customer-level aggregation.
- Joins between sales and customer tables.
- Common Table Expressions (CTEs).
- Window functions.
- `CUME_DIST()` for relative customer scoring.
- Conditional logic for customer classification.

### Final Customer Segments

| Segment | Business Meaning |
|:---|:---|
| Champions | Recent, frequent and high-value customers |
| At-Risk High Value | Previously valuable customers with declining recency |
| Loyal | Customers demonstrating strong purchasing frequency |
| Recent / Promising | Recently active customers with growth potential |
| Hibernating | Customers with low recent engagement |

### Additional Analysis

- Customer distribution by age group.
- Customer distribution by gender.
- Customer distribution by location.
- Revenue contribution by segment.
- Segment-level category preferences.
- Customer revenue concentration using deciles.

**Key Finding:** Champions contribute approximately 42.35% of customer revenue, while At-Risk High Value customers contribute approximately 29.85%.


**Business value:** Provided a framework for prioritising customer retention and targeted marketing activities.

### Stage 6 — Customer Behaviour Analysis

Investigated how customers interact with the business over time

**Objective:** Understand purchasing patterns, repeat behaviour and customer engagement.

### Activities Performed

- Purchase frequency distribution.
- Repeat purchase rate calculation.
- Monthly customer retention analysis.
- Customer months-active analysis.
- Inter-purchase gap calculation using `LAG()`.
- Recency bucket analysis.
- Customer tenure versus spending.
- Category breadth analysis.
- Customer spending by demographics.
- Customer-category revenue matrix.

### Key Finding

The final SQL repeat-purchase analysis identified 950 repeat customers among 989 purchasing customers, giving a repeat-purchase rate of approximately 96.06%.

### Important SQL Concepts Used

`SELECT`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`, `CASE WHEN`, `DISTINCT`, `INNER JOIN`, `LEFT JOIN`, CTEs, subqueries, aggregate functions and window functions.

Important window functions included:

- `RANK()`
- `NTILE()`
- `CUME_DIST()`
- `SUM() OVER()`
- `LAG()`

**Business value:** Helped identify purchasing patterns and opportunities to improve repeat purchases and customer engagement.

## 🐍8. Python Analysis

Python was used to complement SQL with exploratory analysis, statistical testing, clustering evaluation and analytical visualisations.

### A. Data Loading and Exploration

Using Pandas and NumPy:

- Loaded the raw datasets.
- Inspected rows, columns and data types.
- Checked missing values and duplicates.
- Generated descriptive statistics.
- Examined numerical distributions.
- Reviewed customer and product-level patterns.

### B. Exploratory Data Analysis

Using Pandas, Matplotlib and Seaborn:

- Analysed revenue by product category.
- Examined monthly and daily sales trends.
- Compared product revenue and quantity sold.
- Identified top-performing and low-performing products.
- Examined revenue concentration.
- Analysed customer revenue and purchase frequency.
- Visualised price, quantity and customer spending distributions.
- Examined customer purchase behaviour over time.

### C. Statistical Hypothesis Testing

Using SciPy, the project investigated several business questions.

| Statistical Technique | Business Question |
|:---|:---|
| Spearman Correlation | Is customer purchase frequency associated with revenue? |
| Mann–Whitney U Test | Do repeat customers have a different revenue distribution from one-time customers? |
| Kruskal–Wallis Test | Does customer revenue differ across purchase-frequency groups? |


## 📊 Statistical Hypothesis Testing & Key Findings

Three non-parametric statistical tests were conducted to examine the relationship between customer purchasing frequency and revenue, compare spending behaviour between one-time and repeat customers, and identify revenue differences across purchase-frequency segments.

### 1. Statistical Test Results

| Statistical Test | Test Result | Key Finding |
|---|---|---|
| **Spearman Correlation** | ρ = 0.8387, p < 0.001 | Very strong positive association between purchase frequency and customer revenue. |
| **Mann–Whitney U Test** | U = 1,213, p < 0.001 | Statistically significant difference in revenue distributions between one-time and repeat customers. |
| **Kruskal–Wallis Test** | H = 439.5393, p < 0.001 | Statistically significant differences in revenue distributions across purchase-frequency groups. |

### 2. Customer Revenue Comparison

The analysis revealed clear differences in median revenue across customer purchasing-frequency segments.

| Customer Segment | Median Revenue |
|---|---:|
| One-time Customers | 104.54 |
| Occasional Customers | 342.72 |
| Frequent Customers | 811.88 |

The Mann–Whitney U test further confirmed a significant revenue difference between one-time customers (median: 104.54) and repeat customers (median: 672.96).

### 3. Key Statistical Insights

- **Strong Positive Association:** Spearman correlation (ρ = 0.8387) indicates that customers with higher purchasing frequency tend to generate greater revenue.
- **Repeat Customer Value:** Repeat customers demonstrate substantially higher median revenue than one-time customers, highlighting their importance to overall business performance.
- **Frequency-Based Spending Patterns:** The Kruskal–Wallis test confirms statistically significant revenue differences across one-time, occasional and frequent customer groups.
- **High-Value Customer Identification:** Frequent customers generate the highest median revenue (811.88), making them an important segment for customer retention strategies.

### 4. Business Implications & Recommendations

- **Improve Customer Retention:** Introduce loyalty programs and incentives to encourage one-time customers to make repeat purchases.
- **Increase Purchase Frequency:** Implement personalized offers, targeted promotions and engagement campaigns to move occasional customers into frequent-purchasing segments.
- **Prioritize High-Value Customers:** Develop exclusive rewards and retention strategies for frequent customers to maximize customer lifetime value.
- **Data-Driven Segmentation:** Use purchasing-frequency patterns and revenue behaviour to identify valuable customer segments and optimize marketing strategies.

### Conclusion

All three statistical tests returned p-values below 0.001, providing strong statistical evidence of an association between purchasing frequency and customer revenue, as well as significant differences in revenue distributions across customer segments. The findings highlight the importance of repeat purchases, customer retention and frequency-based segmentation in driving revenue growth.

*Note: The Kruskal–Wallis test identifies whether at least one purchase-frequency group differs significantly. Post-hoc pairwise testing is required to determine exactly which groups differ.*

**Conclusion:** All three statistical tests returned p-values below 0.001, providing strong statistical evidence of a relationship between purchasing frequency and customer revenue.


### D. Customer Segmentation with K-Means

K-Means clustering was explored using standardised RFM variables.

The analysis included:
- Feature standardisation.
- Customer clustering.
- Silhouette score evaluation.
- Comparison with rule-based RFM segments using Adjusted Rand Index.

**Purpose:** Explore whether data-driven clustering can identify customer groups with purchasing patterns similar to or different from rule-based segmentation.

Statistical significance is interpreted as evidence of differences or associations, not proof of causation.

## 📊9. Power BI Dashboard Development

The final stage involved developing an interactive four-page Power BI dashboard.

The dashboard was designed to provide different levels of business insight, starting with overall performance and moving towards detailed product, customer and business recommendations.

### Dashboard 1: Executive Overview


<img width="1584" height="908" alt="Screenshot 2026-11-08 150703" src="https://github.com/user-attachments/assets/877a6e2a-2045-4de8-a0cf-ec3e1cb43615" />


#### Objective

Provide management with a consolidated view of overall retail performance, enabling quick monitoring of revenue, transaction activity and product-category contribution.

#### KPIs

- Total Revenue
- Total Transactions
- Total Customers
- Total Units Sold

#### Visualisations

| Visualisation | Business Question |
|:---|:---|
| Monthly Revenue Trend | How is revenue changing over time? |
| Revenue by Product Category | Which categories generate the highest revenue? |
| Top 5 Products by Revenue | Which products contribute the most revenue? |
| Monthly Transaction Volume | How does transaction activity change over time? |

#### Filters and Interactions

- Transaction Date slicer.
- Product Category slicer.
- Dashboard navigation buttons.
- Interactive visual cross-filtering.

#### Business Value

Provides a quick understanding of overall business performance and highlights categories or periods that require further investigation.

---

### Dashboard 2: Product & Inventory Analysis


<img width="1585" height="898" alt="Screenshot 2026-11-08 150731" src="https://github.com/user-attachments/assets/7dbee28f-a4e4-4b98-a997-3e4f72ad16d7" />

#### Objective

Evaluate product-level performance and inventory health to help management identify profitable products, potential stock shortages and excess inventory.

#### KPIs

- Total Products
- Total Product Revenue
- Total Units Sold
- Products Requiring Restock

#### Visualisations

| Visualisation | Business Question |
|:---|:---|
| Top 10 Products by Revenue | Which products generate the highest revenue? |
| Revenue by Product Category | Which categories contribute the most to product revenue? |
| Inventory Status Distribution | How are products distributed across inventory conditions? |
| Revenue & Product Contribution by ABC Class | Which product classes contribute most to revenue? |

#### Filters and Interactions

- Product Category slicer.
- Inventory Status slicer.
- ABC Class slicer.
- Date Period slicer.
- Interactive chart filtering.

#### Business Value

Helps prioritise high-revenue products, identify inventory risks and improve stock allocation decisions.

---

### Dashboard 3: Customer Analytics


<img width="1585" height="895" alt="Screenshot 2026-11-08 150748" src="https://github.com/user-attachments/assets/c20974df-f0c4-4bed-b265-92f8d7feaec0" />

#### Objective

Understand customer purchasing behaviour, customer value and segment-level revenue contribution to support targeted retention and engagement strategies.

#### KPIs

- Total Customers
- Repeat Customer Rate
- Average Revenue per Customer
- Average Purchases per Customer

#### Visualisations

| Visualisation | Business Question |
|:---|:---|
| Customer Count by RFM Segment | How are customers distributed across behavioural segments? |
| Revenue by RFM Segment | Which customer segments generate the highest revenue? |
| Purchase Frequency Distribution | How frequently do customers purchase? |
| Customer Distribution by Age Group | Which age groups represent the largest customer base? |
| Customer Segment Details Table | What are the individual customer RFM scores and classifications? |

#### Customer Details Table

The table provides:

- Customer ID
- Recency
- Frequency
- Monetary
- Segment

Conditional formatting is used to distinguish the customer segments.

#### Filters and Interactions

- Gender slicer.
- Age Group slicer.
- Location slicer.
- Date Period slicer.
- Interactive customer segment selection.

#### Business Value

Enables management to identify valuable customers, monitor customer behaviour and develop targeted retention or reactivation campaigns.

> **Note:** RFM segment values are precomputed in the SQL output for the selected analysis period. A Power BI date slicer does not automatically recalculate those RFM scores unless the underlying measures are redesigned to do so.

---

### Dashboard 4: Business Insights & Recommendations


<img width="1585" height="895" alt="Screenshot 2026-11-08 151000" src="https://github.com/user-attachments/assets/3e8ea4de-6360-4e0b-bcb2-5a8f626bd8ac" />

#### Objective

Bring together the most important findings from the project and translate them into practical recommendations for business decision-makers.

Unlike the previous pages, which focus on specific analytical areas, this page focuses on interpreting results and identifying possible business actions.

#### KPIs

- Total Revenue
- Revenue Growth
- Class A Revenue Contribution
- Products Requiring Restock

#### Visualisations

| Visualisation | Business Question |
|:---|:---|
| Monthly Revenue Trend | Which months show revenue growth or decline? |
| Revenue by Product Category | Which categories contribute most to total revenue? |
| Top 10 Products | Which products are the strongest revenue contributors? |
| Bottom 10 Products | Which products require performance review? |
| ABC Revenue Contribution | How dependent is revenue on different product classes? |

#### Filters and Interactions

- ABC Class slicer.
- Transaction Date slicer.
- Interactive chart filtering.

#### Key Findings Panel

Summarises important observations from the analysis, including:

- Leading revenue-generating categories.
- Revenue contribution of Class A products.
- Monthly revenue fluctuations.
- Differences between high- and low-performing products.
- Inventory replenishment requirements.

#### Business Recommendations Panel

Translates analytical findings into proposed actions, including:

- Prioritising Class A inventory.
- Investigating low-performing products.
- Reviewing revenue fluctuations.
- Improving inventory allocation.
- Strengthening customer retention.

#### Business Value

Provides a management-oriented summary of the analysis and helps turn data findings into actionable decisions.

## 10. Key Business Findings

The analysis generated several useful findings.

### Product Revenue Concentration

ABC analysis showed that a relatively small group of products contributes a large share of overall revenue.

- Class A: 118 products, approximately 80.4% of revenue.
- Class B: 47 products, approximately 14.7% of revenue.
- Class C: 35 products, approximately 4.9% of revenue.

This highlights the importance of monitoring high-contribution products.

### Category-Level Performance

The category analysis identified the following revenue contributions:

| Category | Revenue | Contribution |
|---|---:|---:|
| Home & Kitchen | ₹217,755.94 | 31.0% |
| Electronics | ₹177,548.48 | 25.3% |
| Clothing | ₹162,874.21 | 23.2% |
| Beauty & Health | ₹143,824.99 | 20.5% |

Home & Kitchen was the largest revenue-contributing category in the analysed dataset.

### Product-Level Performance

- Product 17 was identified as the highest-revenue product, generating approximately ₹9,450.
- Product 93 had zero available stock despite recording 79 units sold and approximately ₹2,343.93 in revenue.

This illustrates how product sales performance and current inventory levels can be considered together when prioritising replenishment.

### Customer Purchasing Behaviour

The final SQL repeat-purchase analysis identified 950 repeat customers among 989 purchasing customers, giving a repeat-purchase rate of approximately 96.06%.

The RFM analysis also highlighted a substantial high-value customer group and a meaningful at-risk segment, creating opportunities for targeted customer engagement.

*Note: These findings are based on the corresponding SQL analytical outputs. Dashboard figures and measures should be reconciled against the final exported datasets before being treated as a single source of truth.*

## 💡11. Business Recommendations

Based on the findings, the following recommendations could help improve business performance.

## 9. 💡 Business Recommendations

Based on the analysis, the following strategic actions are recommended to improve customer retention, product performance, inventory management and overall business revenue.

| Area | Recommendation |
|---|---|
| **Customer Retention** | Prioritize engagement with high-value customers and evaluate targeted reactivation campaigns for at-risk customers. |
| **Customer Loyalty** | Explore loyalty benefits and personalized recommendations to encourage repeat purchases. |
| **Inventory Management** | Prioritize replenishment of the six flagged products and review the 16 overstocked products. |
| **Product Strategy** | Monitor Class A products closely and investigate the performance of low-revenue products. |
| **Category Strategy** | Review demand and stock allocation in Home & Kitchen and Electronics, the two largest revenue contributors. |
| **Revenue Monitoring** | Investigate the July revenue decline and monitor category-level performance and transaction volumes. |

### 1. Strengthen Pricing Validation

**Finding:** Product 51 contained a 100x price discrepancy.

**Recommendation:**

- Introduce automated price validation.
- Compare transaction prices with catalogue prices.
- Flag unusually large price differences.
- Preserve original and corrected values for auditing.

**Expected Benefit:** More accurate financial reporting and reduced data-quality risks.

### 2. Focus on High-Revenue Categories

**Finding:** Home & Kitchen contributes approximately 31% of total revenue.

**Recommendation:**

- Monitor product availability in leading categories.
- Evaluate strong-performing products in Electronics and Clothing.
- Investigate the lower-revenue category for pricing and demand opportunities.
- Compare units sold alongside revenue.

**Expected Benefit:** Better product-mix decisions and more focused sales planning.

### 3. Prioritise Class A Products

**Finding:** Class A products contribute approximately 80.4% of revenue.

**Recommendation:**

- Maintain appropriate safety stock.
- Monitor demand and inventory levels frequently.
- Prioritise replenishment for important products.
- Review Class C products before making additional purchasing commitments.

**Expected Benefit:** Reduced stockout risk and more efficient inventory allocation.

### 4. Improve Inventory Management

**Finding:** The analysis identifies six products in the restock-priority output and 16 overstocked products.

**Recommendation:**

- Investigate out-of-stock products.
- Review sales velocity before restocking.
- Reduce unnecessary purchasing of overstocked products.
- Consider promotions for products with weak demand and high stock.

**Expected Benefit:** Better stock availability and reduced excess inventory.

### 5. Retain High-Value Customers

**Finding:** Champions and At-Risk High Value customers together account for a significant proportion of customer revenue.

**Recommendation:**

- Introduce loyalty benefits for Champions.
- Develop targeted win-back campaigns for At-Risk High Value customers.
- Monitor customer recency and frequency.
- Personalise communication using previous purchase behaviour.

**Expected Benefit:** Improved customer engagement and protection of valuable customer relationships.

### 6. Increase Repeat Purchases

**Finding:** The SQL analysis identifies 39 one-time purchasing customers.

**Recommendation:**

- Introduce second-purchase incentives.
- Provide relevant product recommendations.
- Evaluate follow-up campaigns.
- Monitor conversion from first-time to repeat customers.

**Expected Benefit:** Increased repeat engagement and potential improvement in customer lifetime value.

### 7. Improve Targeted Marketing

**Finding:** Customer behaviour varies across RFM segments, demographics and product-category preferences.

**Recommendation:**

- Use customer segments to design relevant campaigns.
- Analyse inter-purchase intervals.
- Identify cross-selling opportunities.
- Tailor offers to customer purchasing preferences.

**Expected Benefit:** More relevant customer communication and improved marketing effectiveness.

## ✅12. Project Outcomes

The project demonstrates an end-to-end analytical workflow:

- Converted raw transactional data into cleaned, structured datasets.
- Developed six stages of SQL analysis covering sales, products, inventory, and customers.
- Applied advanced SQL techniques, including CTEs, joins, aggregations, window functions, ranking, and percentile-based segmentation.
- Used Python for exploratory analysis, statistical testing, bootstrap evaluation, and clustering.
- Built four Power BI dashboard pages for executive reporting and business analysis.
- Translated analytical findings into practical recommendations for retail decision-making.

## 13. Repository Structure

```text
Retail-Analytics/
│
├── data/
│   ├── raw/
│   │   ├── sales_transaction.csv
│   │   ├── customer_profiles.csv
│   │   └── product_inventory.csv
│   │
│   └── cleaned/
│       ├── clean_sales.csv
│       ├── clean_customers.csv
│       └── clean_products.csv
│
├── SQL/
│   ├── 01_Data_Understanding.sql
│   ├── 02_Data_Cleaning.sql
│   ├── 03_Sales_Analysis.sql
│   ├── 04_Product_Inventory_Analysis.sql
│   ├── 05_Customer_RFM_Analysis.sql
│   └── 06_Customer_Behaviour_Analysis.sql
│
├── Python/
│   └── Retail_Analytics_Analysis.ipynb
│
├── PowerBI/
│   ├── Retail_Analytics_Dashboard.pbix
│   └── Dashboard_Screenshots/
│
├── outputs/
│   ├── tables/
│   └── figures/
│
└── README.md
```

*The structure above is a suggested repository layout. Adjust filenames and folders to match the files actually included in the published repository.*

## 14. Skills Demonstrated

**SQL & Database Analysis**
- MySQL
- Data cleaning and transformation
- Joins and aggregations
- CTEs and subqueries
- Window functions
- Ranking and percentile analysis
- RFM customer segmentation
- ABC product classification

**Python & Statistical Analysis**
- Pandas and NumPy
- Exploratory Data Analysis
- Matplotlib and Seaborn
- Statistical hypothesis testing
- Correlation analysis
- Bootstrap resampling
- K-Means clustering
- Model evaluation metrics

**Business Intelligence**
- Power BI
- DAX
- KPI development
- Interactive dashboards
- Data visualisation
- Business insights and recommendations

## 15. Conclusion

This project demonstrates how retail data can be transformed into meaningful business intelligence through a combination of SQL, Python, and Power BI.

By integrating sales performance, product contribution, inventory analysis, and customer segmentation, the project provides a structured approach to understanding retail operations and identifying opportunities for improvement.

Beyond technical implementation, the main focus was on connecting analytical findings with practical business decisions — making the project a complete demonstration of the data analyst workflow.

---

**Author:** Pratham Pulkeet

**Project:** Retail Analytics — SQL, Python & Power BI

**Tools:** MySQL | Python | Power BI | Jupyter Notebook
