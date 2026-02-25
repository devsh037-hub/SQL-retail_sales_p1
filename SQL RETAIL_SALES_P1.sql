CREATE DATABASE project1;
USE project1;
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender VARCHAR(20),
age	INT,
category VARCHAR(20),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

-- PRACTICE THE SELECTION COMMAND....
SELECT * FROM retail_sales;
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(*) AS total_sale FROM retail_sales;
SELECT distinct category FROM retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT * FROM retail_sales;


 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT * FROM retail_sales WHERE category = 'Clothing' AND quantity >'10';

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity < 10
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category, 
    SUM(total_sale) AS total_sales_per_category,
    COUNT(*) AS total_order
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
* FROM retail_sales WHERE category = 'Beauty' AND price_per_unit = 500;


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT                                                  
    SUM(total_sale) AS total_revenue,
 COUNT(*) AS total_transactions
FROM retail_sales
WHERE total_sale > 1000;
									-- Q.5 REPEAT
 SELECT * FROM retail_sales WHERE total_sale > '1000';

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 
 SELECT category, gender, COUNT(transactions_id) AS total_trans FROM retail_sales WHERE gender = 'male' GROUP BY category, gender;
SELECT category, gender, SUM(transactions_id) AS total_trans FROM retail_sales GROUP BY category, gender;

SELECT category, gender, COUNT(transactions_id) AS total_trans FROM retail_sales GROUP BY category, gender ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT YEAR(sale_date), MONTH(sale_date) , ROUND(AVG(total_sale),2) as avg_sale FROM retail_sales GROUP BY 1,2 ORDER BY 1,2;
                                           -- HERE THE ROUND FUNCTION IS USED TO RONUD OFF THE DECIMAL NUMBER OF AVERAGE SALES.
                                           
SELECT YEAR(sale_date), MONTH(sale_date) , SUM(total_sale) total_sale FROM retail_sales GROUP BY 1,2 ORDER BY 1,2;

SELECT YEAR(sale_date) AS YEARS, MONTH(sale_date) AS MONTHS , AVG(total_sale) as avg_sale, RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank_sales FROM retail_sales GROUP BY 1,2 ;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT
customer_id,
SUM(total_sale) AS total_sales 
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category

SELECT
category, 
gender,
COUNT(DISTINCT customer_id)
FROM retail_sales
group by category , gender;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT
sale_time,
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'MORNING'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
        ELSE 'EVENING'
    END AS shift
FROM retail_sales
)
SELECT * FROM hourly_sale;

       -- EXAMPLE OF CASE FUNCTION ....... 
SELECT 
    sale_id,
    total_sale,
    CASE 
        WHEN total_sale > 500 THEN 'High Value'
        WHEN total_sale BETWEEN 200 AND 500 THEN 'Mid Value'
        ELSE 'Low Value'
    END AS sales_category
FROM retail_sales;


-- END OF PROJECT.... 