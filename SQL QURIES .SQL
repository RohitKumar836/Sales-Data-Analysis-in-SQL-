--CREATE TABLE WITH NAME sale

CREATE TABLE sale (
    Row_ID INT PRIMARY KEY,
    Order_ID VARCHAR(25),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(20),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(50),
    Segment VARCHAR(20),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code VARCHAR(10),
    Region VARCHAR(20),
    Product_ID VARCHAR(20),
    Category VARCHAR(30),
    Sub_Category VARCHAR(30),
    Product_Name VARCHAR(150),
    Sales DECIMAL(10,4)
);

-- Load data from local file 

LOAD DATA LOCAL INFILE 'D:/New folder/interview/archive (2)/train.csv'
INTO TABLE sale
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT * FROM sale;

-- What is the total sales?
SELECT SUM(sales) AS TOTAL_SALES
FROM sale;

-- How many unique customers?
SELECT COUNT(DISTINCT(Customer_ID)) AS TOTAL_CUSTOMER
FROM sale;



-- What is the monthly sales trend
SELECT MONTH(Order_Date),SUM(Sales) AS Total
FROM sale
GROUP BY MONTH(Order_Date)
ORDER BY Total DESC;

-- Which month has the highest sales?
SELECT MONTH(Order_Date),SUM(Sales) AS Total
FROM sale
GROUP BY MONTH(Order_Date)
ORDER BY Total DESC
LIMIT 1 ;

-- How do sales vary year-wise (if multiple years)?
SELECT YEAR(Order_Date),SUM(Sales) AS Total
FROM sale
GROUP BY YEAR(Order_Date)
ORDER BY Total DESC;

-- What is the average shipping time?
SELECT 
AVG(DATEDIFF(Ship_Date,Order_Date)) AS SHIPDAYS
FROM sale;

-- Which Ship Mode is used the most?
SELECT Ship_Mode,COUNT(*) AS TOTAL
FROM sale
GROUP BY Ship_Mode
ORDER BY TOTAL DESC
LIMIT 1;

-- Which ship mode results in faster delivery
SELECT Ship_Mode,
avg(datediff(Ship_Date,Order_Date)) AS FASTSHIP
FROM sale
GROUP BY Ship_mode
ORDER BY FASTSHIP
LIMIT 1 ;

-- Which are the top 5 products by sales? 

SELECT Product_Name, SUM(Sales)AS TOP_10
FROM sale
GROUP BY Product_Name
ORDER BY TOP_10 DESC
LIMIT 5;

-- Which category generates the highest sales?
SELECT Category, SUM(Sales) AS TOTAL
FROM sale
GROUP BY Category
ORDER BY TOTAL DESC;

-- Which sub-category is underperforming?
SELECT Sub_Category, SUM(Sales) AS TOTAL
FROM sale
GROUP BY Sub_Category
ORDER BY TOTAL ASC;

-- Which region has the highest sales?
SELECT Region,SUM(Sales) AS Region_Sale
FROM sale
GROUP BY Region
ORDER BY Region_Sale desc
LIMIT 1;

-- Which state generates the most revenue?
SELECT State,SUM(Sales) AS State_Sale
FROM sale
GROUP BY State
ORDER BY State_Sale desc
LIMIT 1;

-- Which cities are top-performing?
SELECT City,SUM(Sales) AS City_Sale
FROM sale
GROUP BY City
ORDER BY City_Sale desc;

-- Who are the top 5 customers by sales?

SELECT Customer_Name,SUM(Sales) AS Total_Sales,
RANK() OVER (ORDER BY SUM(Sales) DESC) AS customer_rank
FROM sale
GROUP BY Customer_Name
LIMIT 5;
-- Which segment (Consumer / Corporate / Home Office) contributes the most?
SELECT Segment, SUM(Sales) AS Total
from  sale
GROUP BY Segment
ORDER BY Total DESC;

-- Which customers order the most frequently?
SELECT Customer_Name,Customer_ID,COUNT(Order_ID) AS Count
FROM sale
GROUP BY Customer_Name,Customer_ID
ORDER BY Count DESC;

SELECT Segment,Category,SUM(Sales) AS total
FROM sale
GROUP BY Segment,Category
ORDER BY total DESC;

-- Which day of the week has highest sales?

SELECT 
    DAYNAME(Order_Date) AS day_name,
    SUM(Sales) AS total_sales
FROM sale
GROUP BY day_name
ORDER BY total_sales DESC;
