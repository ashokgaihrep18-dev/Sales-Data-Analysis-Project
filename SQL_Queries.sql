USE sales_db;
SELECT count(*) AS Total_rows FROM sales_data;
DESCRIBE sales_data;
#Which Year had the highest sales
SELECT Order_Year, ROUND(sum(Sales),2) AS Total_revenue FROM sales_data
GROUP BY  Order_Year
ORDER BY Total_revenue DESC;

-- ---------------------------------------------------------
-- What is the average shipping time?
-- ---------------------------------------------------------
SELECT ROUND(AVG(Ship_Days),0) AS Avg_sSipping_Time FROM sales_data;

-- ---------------------------------------------------------
-- Who are my Top 10 Customers?
-- ---------------------------------------------------------
SELECT `Customer Name`,ROUND(Sales,0) AS Total_Sale_per_Customer FROM sales_data

ORDER BY Sales DESC
limit 10 ;

-- -------------------------------------
-- which is the top sales category
-- ------------------------------------
SELECT Category, count(`Order ID`) AS Num_Order_per_Category FROM sales_data
GROUP BY Category
ORDER BY Num_Order_per_Category  DESC;

-- -------------------------------------
-- Which Region is underperforming?	
-- -------------------------------------
SELECT Region,ROUND(sum(Sales),0) AS Regional_Total FROM sales_data
GROUP BY Region
Having Regional_Total < (SELECT AVG(Total_Sales) 
    FROM (
        SELECT SUM(Sales) AS Total_Sales 
        FROM sales_data 
        GROUP BY Region
    ) AS Regional_Averages
)
ORDER BY Regional_Total ASC;
-- -----------------------------------
-- How many delay shipping order
-- ----------------------------------
SELECT 
    `Ship Mode`, 
    COUNT(*) AS Delayed_Orders,
    ROUND(AVG(Ship_Days), 1) AS Avg_Days
FROM sales_data
WHERE Ship_Days > 5
GROUP BY `Ship Mode`
ORDER BY Delayed_Orders DESC;


CREATE VIEW vw_SalesPerformance AS
SELECT 
    `Order ID`, 
    DATE(`Order Date`) AS Order_Date, 
    DATE(`Ship Date`) AS Ship_Date, 
    `Customer Name`, 
    Segment, 
     `Ship Mode`,
    City, 
    State, 
    Region, 
    Category, 
    `Sub-Category`, 
    ROUND(Sales, 2) AS Sales, 
    Ship_Days, 
    Order_Year
FROM sales_data;
CREATE OR REPLACE VIEW vw_SalesPerformance AS
SELECT 
    `Order ID`, 
    DATE(`Order Date`) AS Order_Date, -- This removes the 00:00:00
    DATE(`Ship Date`) AS Ship_Date,   -- This removes the 00:00:00
    `Ship Mode`,
    `Customer Name`, 
    Segment, 
    City, 
    State, 
    Region, 
    Category, 
    `Sub-Category`, 
    ROUND(Sales, 2) AS Sales, 
    Ship_Days, 
    Order_Year
FROM sales_data;
SELECT * FROM vw_SalesPerformance ;
