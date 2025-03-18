# vehicle-sale-analysis
Vehicle Sales Analysis Project

📌 Project Overview

This project analyzes vehicle sales data across different states and vehicle categories using SQL for data processing and Power BI for visualization.

📂 Files in This Repository

vehicle_sales_analysis.pbix → Power BI report with visualizations

vehicle_sales_queries.sql → SQL queries for data analysis

reshaped_vehicle_sales.csv → Dataset used in the analysis

README.md → Project documentation

📊 Power BI Visualizations

The Power BI report includes:

Bar Chart: Total vehicle sales by state

Stacked Bar Chart: Vehicle sales breakdown by category per state

Pie Chart: Market share of each vehicle category

Top & Bottom 5 States: States with the highest and lowest sales

🛠️ Data Processing Steps

1️⃣ Database & Table Creation

CREATE DATABASE vehicle;
USE vehicle;
CREATE TABLE vehicle_sale (
    state VARCHAR(50),
    category VARCHAR(100),
    total_sold INT,
    PRIMARY KEY (state, category)
);

2️⃣ Data Import

LOAD DATA LOCAL INFILE 'reshaped_vehicle_sales.csv'
INTO TABLE vehicle_sale
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

3️⃣ Key SQL Queries

Total Sales by Category

SELECT category, SUM(total_sold) AS total_sales
FROM vehicle_sale
GROUP BY category
ORDER BY total_sales DESC;

Top 5 States by Sales

SELECT state, SUM(total_sold) AS total_sales
FROM vehicle_sale
GROUP BY state
ORDER BY total_sales DESC
LIMIT 5;

Market Share Analysis

SELECT state, SUM(total_sold) AS total_sales,
       ROUND(SUM(total_sold) * 100.0 / (SELECT SUM(total_sold) FROM vehicle_sale), 2) AS market_share
FROM vehicle_sale
GROUP BY state
ORDER BY market_share DESC;

🚀 How to Use

Run SQL Queries: Use MySQL Workbench to execute the provided SQL queries.

Open Power BI Report: Load vehicle_sales_analysis.pbix to view visualizations.

Modify & Customize: Update queries or visuals as needed for further insights.

🏆 Key Insights

✔️ The highest vehicle sales were recorded in State X.
✔️ Two-wheelers dominate the market in most states.
✔️ Public service vehicles have the lowest sales among categories.
✔️ State Y has the least vehicle sales, contributing only Z% of total sales.

📢 Conclusion

This analysis provides insights into vehicle sales trends, helping businesses understand state-wise market demand. Future improvements could include additional datasets, time-series analysis, and predictive modeling.
