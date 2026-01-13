# **E-Commerce Sales Analytics Project**

## Project Overview:-

- This project presents an end-to-end SQL analysis of eCommerce sales data to evaluate revenue performance, customer behavior, product trends, returns, and regional   performance.
- The goal is to simulate a real-world business analytics use case and derive actionable insights using structured SQL queries.

## Business Goal:-

- To analyze sales transactions and answer critical business questions such as:
- How much revenue is generated and how much is lost due to returns?
- Who are the most valuable customers and how do they behave over time?
- Which products and categories drive sales and which carry higher return risk?
- How do sales, orders, and returns vary across time and regions?

## Database Schema Overview

- The analysis is built on a relational database consisting of five tables:
  Customers - Customer details and account creation date
  Orders - Order-level information including order date and return flag
  OrderDetails - Line-level order details (product and quantity)
  Products - Product details including category and selling price
  Regions - Regional mapping of customers

*Price in the Products table represents the selling price, not cost.*

An ER diagram is included in the [/docs](https://github.com/Dipti-Pathak/ecommerce-sales-analytics/blob/main/ER_diagram.png) folder.

## Key Metrics Defined
Revenue = Quantity × Product Price
Net Revenue = Revenue excluding returned orders
Average Order Value (AOV) = Total Revenue / Total Orders
Return Rate = Returned Orders / Total Orders
Customer Lifetime Value (CLV) = Total historical revenue per customer

## Key Business Insights
### 1. General Sales Performance

- Calculated total revenue and net revenue excluding returns
- Analyzed revenue trends by year and month
- Evaluated revenue contribution by product and category
- Measured Average Order Value (AOV) overall and over time
- Compared average order size by region

### 2. Customer Insights & Segmentation

- Identified top 10 customers by total revenue
- Measured repeat customer rate
- Calculated average time between consecutive orders (region-wise)
- Segmented customers based on total spend:
  Platinum (>1500)
  Gold (1000–1500)
  Silver (500–999)
  Bronze (<500)
- Calculated Customer Lifetime Value (CLV)

### 3. Product & Order Performance

- Identified top 10 products by quantity sold
- Identified top 10 products by revenue
- Calculated return rate by product
- Analyzed return rate by category
- Evaluated average product price by region
- Tracked sales trends by product category

### 4. Temporal Trends Analysis

- Analyzed monthly sales trends
- Evaluated AOV changes by month and week
- Identified seasonality patterns impacting revenue and order value

### 5. Regional Performance Analysis

- Compared order volume across regions
- Analyzed revenue contribution by region
- Identified highest- and lowest-performing regions
- Evaluated regional differences in AOV

### 6. Return & Refund Behavior

- Calculated overall return rate by product category
- Calculated overall return rate by region
- Identified customers with frequent returns

### 7. Revenue Distribution Insights

- Analyzed revenue contribution of top customers
- Analyzed revenue contribution of top products
- Identified revenue concentration and dependency risks

### 8. First-Time vs Repeat Buyer Analysis

- Compared total revenue from first-time vs repeat buyers
- Analyzed return rates for first-time vs repeat customers
- Identified behavioral differences impacting retention and returns

### 9. Product Return Risk Index

- Developed a Product Return Risk Index
- Flagged high-revenue products with disproportionately high return rates
- Highlighted products requiring quality or expectation alignment

## SQL Techniques Used

- Common Table Expressions (CTEs)
- Window Functions (LAG, ROW_NUMBER, DENSE_RANK)
- Conditional Aggregations
- Time-based trend analysis
- Multi-table joins

## Data Validation & Quality Checks

- Checked for duplicate orders and order lines
- Validated null or negative values in price and quantity
- Ensured returned orders were excluded from net revenue calculations

## Assumptions & Limitations

- Product price represents selling price; cost data was unavailable
- Profit and margin analysis were excluded
- CLV is calculated using historical revenue (non-predictive)

## Business Recommendations

- Focus retention strategies on Gold and Platinum customers
- Investigate high-revenue, high-return products
- Improve regional performance where AOV is low but order volume is high
- Leverage seasonal trends for marketing and inventory planning


## Advanced SQL Techniques Used
- Common Table Expressions (CTEs)
- Window functions (`LAG`, `ROW_NUMBER`, `DENSE_RANK`)
- Conditional aggregation
- Date-based trend analysis
- Multi-table joins


## Data Quality & Validation Checks
- Checked for duplicate orders and order lines
- Validated null or negative quantities and prices
- Ensured returned orders were excluded from net revenue calculations


## Assumptions & Limitations
- Product price represents selling price; cost data was not available
- Profit and margin analysis were excluded due to missing cost information
- CLV is calculated as historical revenue-based CLV, not predictive


## Business Recommendations
- Focus retention strategies on Gold and Platinum customer segments
- Investigate high-revenue products with high return rates to reduce revenue loss
- Improve performance in regions with low AOV but high order volume
- Leverage seasonal trends for targeted marketing and inventory planning



## 🛠️ Tools & Skills
- SQL (CTEs, Window Functions, Aggregations)
- Relational Data Modeling
- Business & Sales Analytics
- Analytical Storytelling


## Final Note
This project is designed to demonstrate **real-world analytical thinking**, structured SQL analysis, and the ability to translate raw data into actionable business insights.
