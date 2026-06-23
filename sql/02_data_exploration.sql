-- ====================================================================================
-- Project: Retail Sales Performance Analytics
-- Phase 3: Data Querying & Exploration (SQL)
-- Description: Extracting business insights using SQL aggregation and window functions.
-- ====================================================================================

-- 1. OVERALL REVENUE & PROFIT BY SALES CHANNEL
-- Insight: Which channel is driving the most top-line revenue vs bottom-line profit?
SELECT 
    SalesChannel,
    COUNT(OrderNumber) AS TotalOrders,
    SUM(TotalRevenue) AS TotalRevenue,
    SUM(TotalProfit) AS TotalProfit,
    ROUND(SUM(TotalProfit) / SUM(TotalRevenue) * 100, 2) AS ProfitMargin_Pct
FROM 
    vw_SalesPerformance
GROUP BY 
    SalesChannel
ORDER BY 
    TotalRevenue DESC;


-- 2. MONTH-OVER-MONTH REVENUE GROWTH
-- Insight: Are our sales trending upwards or downwards over time?
WITH MonthlySales AS (
    SELECT 
        DATEPART(year, OrderDate) AS SalesYear,
        DATEPART(month, OrderDate) AS SalesMonth,
        SUM(TotalRevenue) AS Revenue
    FROM 
        vw_SalesPerformance
    GROUP BY 
        DATEPART(year, OrderDate), DATEPART(month, OrderDate)
)
SELECT 
    SalesYear,
    SalesMonth,
    Revenue,
    LAG(Revenue) OVER (ORDER BY SalesYear, SalesMonth) AS PrevMonthRevenue,
    ROUND((Revenue - LAG(Revenue) OVER (ORDER BY SalesYear, SalesMonth)) / 
          LAG(Revenue) OVER (ORDER BY SalesYear, SalesMonth) * 100, 2) AS MoM_Growth_Pct
FROM 
    MonthlySales;


-- 3. DISCOUNT IMPACT ANALYSIS
-- Insight: Does giving a higher discount actually result in more profit?
SELECT 
    CASE 
        WHEN DiscountApplied = 0 THEN 'No Discount'
        WHEN DiscountApplied > 0 AND DiscountApplied <= 50 THEN 'Low Discount (1-50)'
        ELSE 'High Discount (50+)' 
    END AS DiscountTier,
    AVG(OrderQuantity) AS AvgOrderQuantity,
    SUM(TotalProfit) AS TotalProfit
FROM 
    vw_SalesPerformance
GROUP BY 
    CASE 
        WHEN DiscountApplied = 0 THEN 'No Discount'
        WHEN DiscountApplied > 0 AND DiscountApplied <= 50 THEN 'Low Discount (1-50)'
        ELSE 'High Discount (50+)' 
    END
ORDER BY 
    AvgOrderQuantity DESC;


-- 4. DELIVERY EFFICIENCY (SUPPLY CHAIN)
-- Insight: Finding bottlenecks in the delivery process.
SELECT 
    SalesChannel,
    AVG(DeliveryDays) AS AvgDeliveryTimeDays,
    MAX(DeliveryDays) AS MaxDeliveryTimeDays,
    MIN(DeliveryDays) AS MinDeliveryTimeDays
FROM 
    vw_SalesPerformance
GROUP BY 
    SalesChannel;
