# Core DAX Measures Documentation

This document outlines the primary Data Analysis Expressions (DAX) used to power the key performance indicators (KPIs) and time-intelligence features in the Power BI dashboard.

## 1. Core Financial KPIs

### Total Sales
Calculates the total gross revenue across all transactions.
```dax
Total Sales = 
SUMX(
    Fact_Sales, 
    Fact_Sales[Order Quantity] * Fact_Sales[Unit Price]
)
```

### Total Profit
Calculates the net profit by subtracting both the unit cost and applied discounts from the gross sales.
```dax
Total Profit = 
SUMX(
    Fact_Sales, 
    (Fact_Sales[Order Quantity] * Fact_Sales[Unit Price]) 
    - Fact_Sales[Discount Applied] 
    - (Fact_Sales[Order Quantity] * Fact_Sales[Unit Cost])
)
```

### Profit Margin
Calculates the percentage of revenue that translates into profit. Uses `DIVIDE` to safely handle potential divide-by-zero errors.
```dax
Profit Margin = 
DIVIDE(
    [Total Profit], 
    [Total Sales], 
    0
)
```

### Average Order Value (AOV)
Calculates the average revenue generated per unique transaction.
```dax
Average Order Value = 
DIVIDE(
    [Total Sales], 
    DISTINCTCOUNT(Fact_Sales[OrderNumber]), 
    0
)
```

---

## 2. Time Intelligence Measures

### YTD Sales (Year-to-Date)
Calculates the accumulated sales from the beginning of the current calendar year up to the current date context.
```dax
YTD Sales = 
TOTALYTD(
    [Total Sales], 
    Dim_Date[Date]
)
```

### Previous Year Sales (SPLY)
Calculates the sales for the exact same period in the previous year (Same Period Last Year), allowing for direct performance comparisons.
```dax
Previous Year Sales = 
CALCULATE(
    [Total Sales], 
    SAMEPERIODLASTYEAR(Dim_Date[Date])
)
```

### YoY Growth % (Year-over-Year)
Calculates the percentage growth (or decline) in sales compared to the previous year.
```dax
YoY Growth % = 
VAR CurrentSales = [Total Sales]
VAR PreviousSales = [Previous Year Sales]
RETURN
DIVIDE(
    CurrentSales - PreviousSales, 
    PreviousSales, 
    BLANK()
)
```

---

## 3. Advanced Filtering & Logic

### High Margin Product Flag
A binary flag used in slicers and conditional formatting to highlight transactions where the profit margin exceeded 40%.
```dax
High Margin Flag = 
IF(
    [Profit Margin] >= 0.40, 
    "Yes", 
    "No"
)
```

### Sales - In Store Only
Demonstrates the use of `CALCULATE` to alter the filter context, returning sales strictly for the "In-Store" channel regardless of user slicer selections.
```dax
Sales (In-Store Only) = 
CALCULATE(
    [Total Sales], 
    Dim_Channel[ChannelName] = "In-Store"
)
```
