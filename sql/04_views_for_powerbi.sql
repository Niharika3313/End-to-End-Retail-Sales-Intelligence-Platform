-- ====================================================================================
-- Project: Retail Sales Performance Analytics
-- Phase 3.9: Data Modeling optimized for BI Integration
-- Description: Creating optimized SQL Views to act as clean data sources for Power BI 
--              DirectQuery or Import, ensuring logic is centralized in the database.
-- ====================================================================================

-- 1. Executive Dashboard View
-- Aggregated daily summary to drastically reduce data volume imported into Power BI
-- for high-level executive reporting.
CREATE VIEW vw_PowerBI_ExecutiveSummary AS
SELECT 
    OrderDate,
    SalesChannel,
    COUNT(DISTINCT OrderNumber) AS TotalOrders,
    SUM(OrderQuantity) AS TotalUnitsSold,
    SUM(OrderQuantity * UnitPrice - DiscountApplied) AS NetRevenue,
    SUM((OrderQuantity * UnitPrice - DiscountApplied) - (OrderQuantity * UnitCost)) AS NetProfit
FROM 
    RetailSales
GROUP BY 
    OrderDate, SalesChannel;


-- 2. Supply Chain Dashboard View
-- Focused purely on logistics and SLA adherence.
CREATE VIEW vw_PowerBI_SupplyChainMetrics AS
SELECT 
    OrderNumber,
    WarehouseCode,
    SalesChannel,
    OrderDate,
    ShipDate,
    DeliveryDate,
    DATEDIFF(day, OrderDate, ShipDate) AS DaysToShip,
    DATEDIFF(day, ShipDate, DeliveryDate) AS TransitDays,
    DATEDIFF(day, OrderDate, DeliveryDate) AS TotalLeadTime,
    CASE 
        WHEN DATEDIFF(day, OrderDate, DeliveryDate) > 5 THEN 'SLA Breached'
        ELSE 'SLA Met'
    END AS SLA_Status
FROM 
    RetailSales
WHERE 
    DeliveryDate IS NOT NULL;


-- 3. Customer Demographic Summary View
-- Joining facts and dimensions (simulated) for deep demographic filtering.
CREATE VIEW vw_PowerBI_CustomerInsights AS
SELECT 
    c.CustomerID,
    -- Assume we join to a Customer dimension here in a real Star Schema:
    -- c.Region,
    -- c.CustomerSegment,
    COUNT(s.OrderNumber) AS LifetimeOrders,
    SUM(s.OrderQuantity * s.UnitPrice - s.DiscountApplied) AS LifetimeValue,
    MAX(s.OrderDate) AS LastPurchaseDate,
    DATEDIFF(day, MAX(s.OrderDate), GETDATE()) AS DaysSinceLastPurchase
FROM 
    RetailSales s
    -- JOIN DimCustomer c ON s.CustomerID = c.CustomerID
GROUP BY 
    c.CustomerID;
