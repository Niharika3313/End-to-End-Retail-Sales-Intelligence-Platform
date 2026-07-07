-- CREATE DATABASE project2;

USE project2;

-- DIMENSION TABLES --

-- customers table

CREATE TABLE customers(
 CustomerId INT PRIMARY KEY,
 CustomerName VARCHAR(100)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cadenality_clean_data/customers_clean.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(CustomerId, CustomerName);

-- products table

CREATE TABLE products(
 ProductId INT PRIMARY KEY,
 ProductName VARCHAR(100)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cadenality_clean_data/products_clean.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(ProductId, ProductName);

-- salesTeam table

CREATE TABLE salesTeam(
 SalesTeamId INT PRIMARY KEY,
 SalesTeam VARCHAR(100),
 Region VARCHAR(50)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cadenality_clean_data/sales_team_clean.csv'
INTO TABLE salesTeam
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(SalesTeamId, SalesTeam, Region);
 
-- regions table

CREATE TABLE regions(
 StateCode VARCHAR(10) PRIMARY KEY,
 State VARCHAR(100),
 Region VARCHAR(100)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cadenality_clean_data/regions_clean.csv'
INTO TABLE regions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(StateCode, State, Region);


-- stores table

CREATE TABLE stores(
 StoreId INT PRIMARY KEY,
 CityName VARCHAR(100),
 County VARCHAR(100),
 StateCode VARCHAR(10),
 State VARCHAR(100),
 `Type` VARCHAR(50),
 Latitude FLOAT,
 Longitude FLOAT,
 AreaCode INT,
 Population INT,
 HouseholdIncome INT,
 MedianIncome INT,
 LandArea BIGINT,
 WaterArea BIGINT,
 TimeZone VARCHAR(100),
 FOREIGN KEY (StateCode) REFERENCES regions(StateCode)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cadenality_clean_data/stores_clean.csv'
INTO TABLE stores
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(StoreId, CityName, County, StateCode, State, `Type`, Latitude, Longitude, AreaCode, Population,
HouseholdIncome, MedianIncome, LandArea, WaterArea, TimeZone);

-- FACT TABLE --

-- salesOrders table

CREATE TABLE salesOrders(
 OrderNumber VARCHAR(50) PRIMARY KEY,
 SalesChannel VARCHAR(100),
 WarehouseCode VARCHAR(100),
 ProcuredDate DATE NOT NULL,
 OrderDate DATE NOT NULL,
 ShipDate DATE NOT NULL,
 DeliveryDate DATE NOT NULL,
 CurrencyCode VARCHAR(10),
 SalesTeamId INT NOT NULL,
 CustomerId INT NOT NULL,
 StoreId INT NOT NULL,
 ProductId INT NOT NULL,
 OrderQuantity INT NOT NULL,
 DiscountApplied FLOAT,
 UnitPrice FLOAT,
 UnitCost FLOAT,
 TotalRevenue FLOAT,
 TotalProfit FLOAT,
 DeliveryDays INT,
 FOREIGN KEY (SalesTeamId) REFERENCES salesTeam(SalesTeamId),
 FOREIGN KEY (CustomerId) REFERENCES customers(CustomerId),
 FOREIGN KEY (StoreId) REFERENCES stores(StoreId),
 FOREIGN KEY (ProductId) REFERENCES products(ProductId)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cadenality_clean_data/sales_orders_clean.csv'
INTO TABLE salesOrders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(OrderNumber, SalesChannel, WarehouseCode, ProcuredDate, OrderDate, ShipDate, DeliveryDate, CurrencyCode,
SalesTeamId, CustomerId, StoreId, ProductId, OrderQuantity, DiscountApplied, UnitPrice, UnitCost, TotalRevenue, TotalProfit,
DeliveryDays);

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM stores;
SELECT * FROM regions;
SELECT * FROM salesTeam;
SELECT * FROM salesOrders;
