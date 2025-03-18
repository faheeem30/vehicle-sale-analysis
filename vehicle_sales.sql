# CREATE DATABASE AND TABLE  
CREATE database vehicle;
use vehicle;
# create TABLE FOR VEHICLES SALES DATA
create table vehicle_sale(
	state varchar(50),
	category varchar(100),
	total_sold INT,
    PRIMARY KEY(state, category)
 );

#LOAD DATA FROM CSV FILE INTO TABLE
LOAD DATA LOCAL INFILE "C:\\Users\\moham\\OneDrive\\Desktop\\bi project\\reshaped_vehicle_sales.csv"
INTO TABLE vehicle_sale
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# CHECK IF LOCAL INFILE IS ENABLED  
 SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

# Count total records 
SELECT COUNT(*) FROM vehicle_sale;

#Check for missing values in any column  
SELECT * FROM vehicle_sale WHERE state IS NULL OR category IS NULL OR total_sold IS NULL;

# Find duplicate state-category entries  
SELECT state, category, COUNT(*) 
FROM vehicle_sale 
GROUP BY state, category 
HAVING COUNT(*) > 1;
SELECT MIN(total_sold), MAX(total_sold), AVG(total_sold) FROM vehicle_sale;

# TOTAL VEHICLE SALES BY STATE
SELECT state, SUM(total_sold) AS total_vehicles_sold
FROM vehicle_sale
GROUP BY state
ORDER BY total_vehicles_sold DESC;

# SALES BREAKDOWN BY CATEGORY  
SELECT category, SUM(total_sold) AS total_sales  
FROM vehicle_sale  
GROUP BY category  
ORDER BY total_sales DESC;  

# TOP 5 STATES FOR EACH CATEGORY BASED ON SALES  
SELECT state, category, total_sold  
FROM (  
    SELECT state, category, total_sold,  
           DENSE_RANK() OVER (PARTITION BY category ORDER BY total_sold DESC) AS ranking  
    FROM vehicle_sale  
) ranked_data  
WHERE ranking <= 5;  

# MARKET SHARE PERCENTAGE FOR EACH STATE  
SELECT state,  
       SUM(total_sold) AS total_sales,  
       ROUND(SUM(total_sold) * 100.0 / (SELECT SUM(total_sold) FROM vehicle_sale), 2) AS market_share  
FROM vehicle_sale  
GROUP BY state  
ORDER BY market_share DESC;  

# STATES WITH LOWEST VEHICLE SALES  
SELECT state, SUM(total_sold) AS total_sales  
FROM vehicle_sale  
GROUP BY state  
ORDER BY total_sales ASC  
LIMIT 5;  

# STATES WITH HIGHEST VEHICLE SALES  
SELECT state, SUM(total_sold) AS total_vehicles_sold  
FROM vehicle_sale  
GROUP BY state  
ORDER BY total_vehicles_sold DESC;  

# TOP SELLING CATEGORY IN EACH STATE  
SELECT state, category, total_sold  
FROM (  
    SELECT state, category, total_sold,  
           RANK() OVER (PARTITION BY state ORDER BY total_sold DESC) AS ranking  
    FROM vehicle_sale  
) ranked_data  
WHERE ranking = 1;  

# TOTAL SALES FOR EACH CATEGORY  
SELECT category, SUM(total_sold) AS total_sales  
FROM vehicle_sale  
GROUP BY category  
ORDER BY total_sales DESC;  

# COUNT TOTAL RECORDS  
SELECT COUNT(*) FROM vehicle_sale;  

# CHECK FOR NULL VALUES IN SALES DATA  
SELECT * FROM vehicle_sale WHERE total_sold IS NULL;  

# TOTAL VEHICLE SALES PER STATE AND CATEGORY  
SELECT state, category, SUM(total_sold) AS total  
FROM vehicle_sale  
GROUP BY state, category  
ORDER BY state, total DESC;  

# TOTAL VEHICLE SALES PER STATE  
SELECT state, SUM(total_sold) AS total_vehicles  
FROM vehicle_sale  
GROUP BY state  
ORDER BY total_vehicles DESC;  

# TOP 5 STATES FOR TWO-WHEELER SALES  
SELECT state, SUM(total_sold) AS two_wheelers  
FROM vehicle_sale  
WHERE category LIKE '%Two Wheeler%'  
GROUP BY state  
ORDER BY two_wheelers DESC  
LIMIT 5;  

# TOP 5 STATES FOR PUBLIC SERVICE VEHICLE SALES  
SELECT state, SUM(total_sold) AS public_service_vehicles  
FROM vehicle_sale  
WHERE category LIKE '%Public Service%'  
GROUP BY state  
ORDER BY public_service_vehicles DESC  
LIMIT 5;  

# CHECK FOR DUPLICATE STATE-CATEGORY ENTRIES  
SELECT state, category, COUNT(*)  
FROM vehicle_sale  
GROUP BY state, category  
HAVING COUNT(*) > 1;  

# CALCULATE PERCENTAGE SHARE OF EACH CATEGORY IN A STATE  
SELECT state,  
       category,  
       total_sold,  
       (total_sold * 100.0) / SUM(total_sold) OVER (PARTITION BY state) AS percentage_share  
FROM vehicle_sale  
ORDER BY state, total_sold DESC;  

# TOP CATEGORY SOLD IN EACH STATE  
SELECT state,  
       category,  
       total_sold  
FROM (  
    SELECT state,  
           category,  
           total_sold,  
           RANK() OVER (PARTITION BY state ORDER BY total_sold DESC) AS rnk  
    FROM vehicle_sale  
) ranked  
WHERE rnk = 1;  

# TOTAL SALES PER CATEGORY ACROSS STATES  
SELECT category, SUM(total_sold) AS total_sold_across_states  
FROM vehicle_sale  
GROUP BY category  
ORDER BY total_sold_across_states DESC;  

# DATABASE VERSION CHECK  
SELECT VERSION();  

# PREVIEW FIRST 10 RECORDS FROM DATASET  
SELECT * FROM vehicle.vehicle_sale LIMIT 10;  

# CHECK DATABASE SERVER HOSTNAME  
SELECT @@hostname;  
