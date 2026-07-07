/*
Retail Sales Analysis

This dataset contains retail sales data for a home essentials company.
This SQL script analyzes overall business performance, including revenue, profit, products, customers, regions, sales channels, and operational metrics.
*/

-- 1. Overall Performance
--    - Total revenue, profit, margin

SELECT 
	COUNT(*) AS TotalRecords
FROM salesOrders;

SELECT
	ROUND(SUM(TotalRevenue), 0) as TotalRevenue,
    ROUND(SUM(TotalProfit), 0) as TotalProfit,
    ROUND(SUM(TotalRevenue) - SUM(TotalProfit), 0) AS TotalCost,
    ROUND((SUM(TotalProfit) / SUM(TotalRevenue))*100, 2) AS ProfitMargin_Pct
FROM salesOrders;

--    - Revenue by sales channel

SELECT
	SalesChannel,
	ROUND(SUM(TotalRevenue), 0) AS Revenue,
    ROUND(SUM(TotalProfit), 0) AS Profit,
    ROUND(((SUM(TotalProfit) / SUM(TotalRevenue)) * 100), 2) AS ProfitMargin_Pct
FROM salesOrders
GROUP BY SalesChannel
ORDER BY Revenue DESC;

-- 2. Product Analysis
--    - Top products by revenue and profit

SELECT 
	ProductName,
    ROUND(SUM(TotalRevenue), 0) AS Revenue,
    ROUND(SUM(TotalProfit), 0) AS Profit,
    ROUND(((SUM(TotalProfit) / SUM(TotalRevenue)) * 100), 2) AS ProfitMargin_Pct
FROM salesOrders
LEFT JOIN products ON salesOrders.ProductId = products.ProductId
GROUP BY ProductName
ORDER BY Revenue DESC;

--    - Discount impact on performance

SELECT
	CASE
		WHEN DiscountApplied < 0.1 THEN '0-10%'
        WHEN DiscountApplied < 0.2 THEN '10-20%'
        WHEN DiscountApplied < 0.3 THEN '20-30%'
        ELSE '30%+'
	END AS Discount_Applied,
    SUM(OrderQuantity) AS UnitsSold,
    ROUND(SUM(TotalRevenue), 0) AS Revenue,
    ROUND(SUM(TotalProfit), 0) AS Profit,
    ROUND(((SUM(TotalProfit) / SUM(TotalRevenue)) * 100), 2) AS ProfitMargin_Pct
FROM salesOrders
GROUP BY Discount_Applied
ORDER BY Profit DESC;

-- 3. Regional Analysis
--    - Revenue and profit by region

SELECT
	Region,
    ROUND(SUM(TotalRevenue), 0) AS Revenue,
    ROUND(SUM(TotalProfit), 0) AS Profit,
    ROUND(((SUM(TotalProfit) / SUM(TotalRevenue)) * 100), 2) AS ProfitMargin_Pct
FROM salesOrders
LEFT JOIN stores ON salesOrders.StoreId = stores.StoreId
LEFT JOIN regions ON stores.StateCode = regions.StateCode
GROUP BY Region
ORDER BY Revenue DESC;

--    - Top performing stores

SELECT
	salesOrders.StoreId,
    CityName,
    ROUND(SUM(TotalRevenue), 0) AS Revenue,
    ROUND(SUM(TotalProfit), 0) AS Profit,
    ROUND(((SUM(TotalProfit) /SUM(TotalRevenue))* 100), 2) AS ProfitMargin
FROM salesOrders
LEFT JOIN stores ON salesOrders.StoreId = stores.StoreId
GROUP BY
	salesOrders.StoreId,
    stores.CityName
ORDER BY Revenue DESC;


-- 4. Customer Analysis
--    - Top customers by revenue

SELECT
	CustomerName,
    ROUND(SUM(TotalRevenue), 0) AS Revenue,
    COUNT(OrderNumber) AS OrderCount,
    ROUND(SUM(TotalRevenue) / COUNT(OrderNumber), 2) AS AvgOrderValue,
    ROUND(SUM(TotalProfit), 0) AS Profit,
    ROUND(((SUM(TotalProfit) /SUM(TotalRevenue))* 100), 2) AS ProfitMargin
FROM salesOrders
LEFT JOIN customers ON salesOrders.CustomerId = customers.CustomerId
GROUP BY CustomerName
ORDER BY Revenue DESC;

-- 5. Time-based Analysis
--    - Monthly revenue trend (MoM growth)

WITH MonthlySales AS (
    SELECT 
        DATE_FORMAT(OrderDate, '%Y-%m') AS YearMonth,   
        ROUND(SUM(TotalRevenue), 0) AS Revenue
	FROM salesOrders
	GROUP BY YearMonth
)
SELECT 
	*,
    LAG(Revenue) OVER (ORDER BY YearMonth) AS PrevMonthRevenue,
    ROUND(((Revenue - LAG(Revenue) OVER (ORDER BY YearMonth))
		/ LAG(Revenue) OVER (ORDER BY YearMonth)) * 100, 2) AS MoM_Growth_Pct 
FROM MonthlySales;

--    - Product trend by order date

SELECT
    ProductName,
    ROUND(SUM(CASE WHEN DATE_FORMAT(OrderDate, '%Y') = '2018' THEN TotalRevenue ELSE 0 END), 0) AS Rev_2018,
    ROUND(SUM(CASE WHEN DATE_FORMAT(OrderDate, '%Y') = '2019' THEN TotalRevenue ELSE 0 END), 0) AS Rev_2019,
    ROUND(SUM(CASE WHEN DATE_FORMAT(OrderDate, '%Y') = '2020' THEN TotalRevenue ELSE 0 END), 0) AS Rev_2020
FROM salesOrders
LEFT JOIN products ON salesOrders.ProductId = products.ProductId
GROUP BY ProductName
ORDER BY Rev_2020 DESC;


-- 6. Operational Analysis
--    - Delivery performance by channel

SELECT
	SalesChannel,
    ROUND(AVG(DeliveryDays), 2) AS DeliveryDays,
    COUNT(OrderNumber) AS OrderCount
FROM salesOrders
GROUP BY SalesChannel
ORDER BY DeliveryDays ASC;

--    - Top performing sales teams

SELECT
	SalesTeam,
    ROUND(SUM(TotalRevenue), 0) AS Revenue,
    ROUND(SUM(TotalProfit), 0) AS Profit,
    ROUND(((SUM(TotalProfit) / SUM(TotalRevenue)) * 100), 2) AS ProfitMargin_Pct,
    COUNT(OrderNumber) AS CountOfSales
FROM salesOrders
LEFT JOIN salesTeam ON salesOrders.SalesTeamId = salesTeam.SalesTeamId
GROUP BY SalesTeam
ORDER BY Revenue DESC;

-- - Top warehouses by delivery efficiency

SELECT
    WarehouseCode,
    ROUND(AVG(DeliveryDays), 2) AS AvgDeliveryDays,
    COUNT(OrderNumber) AS OrderCount
FROM salesOrders
GROUP BY WarehouseCode
ORDER BY AvgDeliveryDays ASC;

-- Cumulative Revenue

SELECT
    DATE_FORMAT(OrderDate, '%Y-%m') AS YearMonth,
    ROUND(SUM(TotalRevenue), 0) AS MonthlyRevenue,
    ROUND(SUM(SUM(TotalRevenue)) OVER (ORDER BY DATE_FORMAT(OrderDate, '%Y-%m')), 0) AS CumulativeRevenue
FROM salesOrders
GROUP BY YearMonth
ORDER BY YearMonth;