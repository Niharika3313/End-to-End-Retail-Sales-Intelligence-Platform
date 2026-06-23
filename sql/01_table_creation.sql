-- ====================================================================================
-- Project: Retail Sales Performance Analytics
-- Phase 3: Database Storage (SQL)
-- Description: Table schema creation and data import setup for the sales database.
-- ====================================================================================

-- 1. Create the main Sales table
CREATE TABLE RetailSales (
    OrderNumber VARCHAR(50) PRIMARY KEY,
    SalesChannel VARCHAR(50),
    WarehouseCode VARCHAR(50),
    ProcuredDate DATE,
    OrderDate DATE,
    ShipDate DATE,
    DeliveryDate DATE,
    CurrencyCode VARCHAR(10),
    SalesTeamID INT,
    CustomerID INT,
    StoreID INT,
    ProductID INT,
    OrderQuantity INT,
    DiscountApplied DECIMAL(10, 2),
    UnitPrice DECIMAL(10, 2),
    UnitCost DECIMAL(10, 2)
);

-- Note: In a real-world scenario, you would also have Dimension tables
-- for Products, Customers, Stores, and SalesTeams (Star Schema layout).
-- For this pipeline, we are loading the flattened fact table.

-- 2. Add calculated columns (Optional depending on dialect, showing Standard SQL approach)
-- Note: Some analysts prefer calculating these in views instead of base tables.

CREATE VIEW vw_SalesPerformance AS
SELECT 
    OrderNumber,
    SalesChannel,
    OrderDate,
    DeliveryDate,
    OrderQuantity,
    UnitPrice,
    UnitCost,
    DiscountApplied,
    -- Calculate Revenue
    (OrderQuantity * UnitPrice) - DiscountApplied AS TotalRevenue,
    -- Calculate Profit
    ((OrderQuantity * UnitPrice) - DiscountApplied) - (OrderQuantity * UnitCost) AS TotalProfit,
    -- Calculate Delivery Time in days
    DATEDIFF(day, OrderDate, DeliveryDate) AS DeliveryDays
FROM 
    RetailSales;
