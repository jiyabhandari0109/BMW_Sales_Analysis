DROP DATABASE IF EXISTS `BMW_Sales`;
CREATE DATABASE `BMW_Sales`;
USE `BMW_Sales`;

/* EXPLORATORARY DATA ANALYSIS */

-- In which regions are the products sold?
SELECT DISTINCT Region
	FROM sales;
    
-- Which models are sold by the company?
SELECT DISTINCT Model
	FROM sales;
    
-- What is the total sales quantity each year?
SELECT year,
	   SUM(sales_volume) AS sales
	FROM sales
GROUP BY 1
ORDER BY 1;

-- What is the sales quantity in each region annually?
SELECT year,
       region, 
       SUM(Sales_Volume) AS Sales
	FROM sales
GROUP BY 1, 2
ORDER BY 2, 1;

-- What are the total sales in each region?
SELECT region, 
       SUM(sales_volume) AS sales
	FROM sales
GROUP BY 1
ORDER BY 2 DESC;

-- What’s the % of electric vehicle sales over years?
SELECT year,
       SUM(CASE WHEN fuel_type = 'electric' THEN sales_volume ELSE 0 END) * 100.0 / SUM(sales_volume) AS ev_percentage
	FROM sales
GROUP BY 1
ORDER BY 1;

-- What is the sales quantity in asia each year?
SELECT year, 
	   region, 
       SUM(sales_volume) AS sales
	FROM sales
WHERE region = 'asia'
GROUP BY 1, 2
ORDER BY 1, 2;

-- What are the total sales of each model?
SELECT model, 
	   SUM(sales_volume) AS sales
	FROM sales
GROUP BY 1
ORDER BY 2 DESC;

-- Which model is sold the most annaully?
SELECT year, 
	   model, 
       total_sales
FROM (
    SELECT year,
           model,
           SUM(sales_volume) AS total_sales,
           RANK() OVER (PARTITION BY year ORDER BY SUM(sales_volume) DESC) AS ranking
    FROM sales
    GROUP BY 1, 2
) AS ranked
WHERE ranking = 1
ORDER BY 1;

-- How much is each model sold annaully?
SELECT year, 
	   model, 
       SUM(sales_volume) AS sales
	FROM sales
GROUP BY 1, 2
ORDER BY 1, 2;

-- How much of each fuel type is sold?
SELECT fuel_type, 
	   SUM(sales_volume) AS sales
	FROM sales
GROUP BY 1
ORDER BY 2 DESC;

-- Which fuel type is sold the most each year?
SELECT year, 
	   fuel_type, 
       total_sales
FROM (
    SELECT year,
           fuel_type,
           SUM(sales_volume) AS total_sales,
           RANK() OVER (PARTITION BY year ORDER BY SUM(sales_volume) DESC) AS ranking
		FROM sales
    GROUP BY 1, 2
) AS ranked
WHERE ranking = 1
ORDER BY 1;

-- Which transmission is sold the most each year?
SELECT year,
       transmission,
       total_sales
FROM (
    SELECT year,
		   transmission,
           SUM(sales_volume) AS total_sales,
           RANK() OVER (PARTITION BY year ORDER BY SUM(sales_volume) DESC) AS ranking
		FROM sales
    GROUP BY 1, 2
) AS ranked
WHERE ranking = 1
ORDER BY 1;

-- Which colour is sold the most each year?
SELECT year, 
	   color, 
	   total_sales
FROM (
    SELECT year,
           color,
           SUM(sales_volume) AS total_sales,
           RANK() OVER (PARTITION BY year ORDER BY SUM(sales_volume) DESC) AS ranking
		FROM sales
    GROUP BY 1, 2
) AS ranked
WHERE ranking = 1
ORDER BY 1;

-- Which region had the highest sales each year?
SELECT year, 
	   region, 
	   total_sales
FROM (
    SELECT year,
           region,
           SUM(sales_volume) AS total_sales,
           RANK() OVER (PARTITION BY year ORDER BY SUM(sales_volume) DESC) AS ranking
		FROM sales
    GROUP BY 1, 2
) AS ranked
WHERE ranking = 1
ORDER BY 1;
