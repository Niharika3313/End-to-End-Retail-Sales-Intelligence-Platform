-- ====================================================================================
-- Project: Retail Sales Performance Analytics
-- Phase 3.5: Advanced Analytics & Complex Aggregations (SQL)
-- Description: Using Common Table Expressions (CTEs), Cohort Analysis, and Window 
--              Functions to extract deep strategic insights.
-- ====================================================================================

-- 1. COHORT ANALYSIS (CUSTOMER RETENTION / LIFETIME VALUE)
-- Insight: Analyzing the purchasing behavior of customer cohorts based on their first purchase month.
WITH CustomerFirstPurchase AS (
    SELECT 
        CustomerID,
        MIN(OrderDate) AS FirstPurchaseDate,
        DATEPART(year, MIN(OrderDate)) AS CohortYear,
        DATEPART(month, MIN(OrderDate)) AS CohortMonth
    FROM 
        vw_SalesPerformance
    GROUP BY 
        CustomerID
),
CohortMonthlyActivity AS (
    SELECT 
        c.CohortYear,
        c.CohortMonth,
        DATEPART(year, s.OrderDate) AS ActivityYear,
        DATEPART(month, s.OrderDate) AS ActivityMonth,
        COUNT(DISTINCT s.CustomerID) AS ActiveCustomers,
        SUM(s.TotalRevenue) AS CohortRevenue
    FROM 
        vw_SalesPerformance s
    JOIN 
        CustomerFirstPurchase c ON s.CustomerID = c.CustomerID
    GROUP BY 
        c.CohortYear, c.CohortMonth, DATEPART(year, s.OrderDate), DATEPART(month, s.OrderDate)
)
SELECT 
    CohortYear,
    CohortMonth,
    ActivityYear,
    ActivityMonth,
    -- Calculate the number of months since the first purchase (Month N)
    (ActivityYear - CohortYear) * 12 + (ActivityMonth - CohortMonth) AS MonthIndex,
    ActiveCustomers,
    CohortRevenue
FROM 
    CohortMonthlyActivity
ORDER BY 
    CohortYear, CohortMonth, MonthIndex;


-- 2. 7-DAY ROLLING AVERAGE REVENUE (SMOOTHING VOLATILITY)
-- Insight: Daily sales can be volatile. A 7-day rolling average provides a clearer trend line.
WITH DailyRevenue AS (
    SELECT 
        OrderDate,
        SUM(TotalRevenue) AS DailyTotal
    FROM 
        vw_SalesPerformance
    GROUP BY 
        OrderDate
)
SELECT 
    OrderDate,
    DailyTotal,
    AVG(DailyTotal) OVER (
        ORDER BY OrderDate 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS Rolling7DayAvgRevenue
FROM 
    DailyRevenue
ORDER BY 
    OrderDate;


-- 3. PARETO ANALYSIS (80/20 RULE) ON PRODUCTS
-- Insight: Identifying the top 20% of products that generate 80% of the revenue.
WITH ProductRevenue AS (
    SELECT 
        ProductID,
        SUM(TotalRevenue) AS ProductTotalRevenue
    FROM 
        RetailSales
    GROUP BY 
        ProductID
),
CumulativeRevenue AS (
    SELECT 
        ProductID,
        ProductTotalRevenue,
        SUM(ProductTotalRevenue) OVER (ORDER BY ProductTotalRevenue DESC) AS RunningTotal,
        SUM(ProductTotalRevenue) OVER () AS OverallTotalRevenue
    FROM 
        ProductRevenue
)
SELECT 
    ProductID,
    ProductTotalRevenue,
    RunningTotal,
    OverallTotalRevenue,
    (RunningTotal / OverallTotalRevenue) * 100 AS CumulativePercentage,
    CASE 
        WHEN (RunningTotal / OverallTotalRevenue) <= 0.80 THEN 'Top 80% Contributor'
        ELSE 'Bottom 20% Contributor' 
    END AS ParetoCategory
FROM 
    CumulativeRevenue
ORDER BY 
    ProductTotalRevenue DESC;
