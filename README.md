# Vehicle Sales Analysis Project

## 📌 Project Overview
This project analyzes vehicle sales data across different states and vehicle categories using **SQL** for data processing and **Power BI** for visualization.

## 📂 Files in This Repository
- **vehicle_sales_analysis.pbix** → Power BI report with visualizations
- **vehicle_sales_queries.sql** → SQL queries for data analysis
- **reshaped_vehicle_sales.csv** → Dataset used in the analysis
- **README.md** → Project documentation

## 📊 Power BI Visualizations
The Power BI report includes:
- **Bar Chart:** Total vehicle sales by state
- **Stacked Bar Chart:** Vehicle sales breakdown by category per state
- **Pie Chart:** Market share of each vehicle category
- **Top & Bottom 5 States:** States with the highest and lowest sales

## 🛠️ Data Processing Steps
### 1⃣ Database & Table Creation
```sql
CREATE DATABASE vehicle;
USE vehicle;
CREATE TABLE vehicle_sale (
    state VARCHAR(50),
    category VARCHAR(100),
    total_sold INT,
    PRIMARY KEY (state, category)
);
```
### 2⃣ Data Import
```sql
LOAD DATA LOCAL INFILE 'reshaped_vehicle_sales.csv'
INTO TABLE vehicle_sale
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```
### 3⃣ Key SQL Queries
- **Total Sales by Category**
```sql
SELECT category, SUM(total_sold) AS total_sales
FROM vehicle_sale
GROUP BY category
ORDER BY total_sales DESC;
```
- **Top 5 States by Sales**
```sql
SELECT state, SUM(total_sold) AS total_sales
FROM vehicle_sale
GROUP BY state
ORDER BY total_sales DESC
LIMIT 5;
```
- **Market Share Analysis**
```sql
SELECT state, SUM(total_sold) AS total_sales,
       ROUND(SUM(total_sold) * 100.0 / (SELECT SUM(total_sold) FROM vehicle_sale), 2) AS market_share
FROM vehicle_sale
GROUP BY state
ORDER BY market_share DESC;
```

## 🚀 How to Use
1. **Verify MySQL Connector Installation:**
   - Open **ODBC Data Sources (64-bit)** in Windows.
   - Go to the **Drivers** tab and check if **MySQL ODBC 8.0 Unicode Driver** is listed.
     - ❌ **Not found?** Install MySQL Connector/ODBC 8.0.33+ again.
     - ✅ **Found?** Move to the next step.
2. **Install MySQL .NET Connector (Important for Power BI):**
   - Download and install **MySQL Connector/NET 8.0.33** or later from the MySQL website.
3. **Run SQL Queries:** Use MySQL Workbench to execute the provided SQL queries.
4. **Open Power BI Report:** Load `vehicle_sales_analysis.pbix` to view visualizations.
5. **Modify & Customize:** Update queries or visuals as needed for further insights.

## 🏆 Key Insights
✔️ The highest vehicle sales were recorded in **State X**.
✔️ **Two-wheelers** dominate the market in most states.
✔️ **Public service vehicles** have the lowest sales among categories.
✔️ **State Y** has the least vehicle sales, contributing only **Z%** of total sales.

## 📢 Conclusion
This analysis provides insights into vehicle sales trends, helping businesses understand state-wise market demand. Future improvements could include additional datasets, time-series analysis, and predictive modeling.
