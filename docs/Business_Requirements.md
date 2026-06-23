# Business Requirements Document (BRD)

## 1. Project Background
The Executive Management team requires a unified view of historical retail sales performance to identify inefficiencies in our supply chain, optimize our pricing strategies, and determine which sales channels offer the best Return on Investment (ROI).

## 2. Business Objectives
As the primary Data Analyst on this project, the objectives are to answer the following core business questions:

1.  **Channel Profitability**: Which sales channels (Online, In-Store, Distributor) drive the most top-line revenue, and do they align with our highest profit margins?
2.  **Supply Chain Efficiency**: What is the average lead time from order placement to final delivery? Are there specific channels suffering from delivery bottlenecks?
3.  **Pricing Strategy (Discounts)**: How does the application of discounts impact the average order quantity? Does a higher discount tier cannibalize overall profitability?
4.  **Growth Velocity**: What is the Month-over-Month (MoM) revenue growth trajectory, and are there seasonal dips we need to proactively address?

## 3. Scope of Work
*   **Data Extraction**: Ingest the raw Excel dataset containing historical transaction records.
*   **Data Transformation (ETL)**: Utilize Python (Pandas) to clean the data, handle missing values, and engineer calculated fields such as `TotalRevenue`, `TotalCost`, and `DeliveryDays`.
*   **Data Storage & Querying**: Simulate a relational database environment using SQL to perform complex aggregations, window functions, and cohort analysis.
*   **Data Visualization**: Design and deploy an interactive Power BI dashboard that allows non-technical stakeholders to filter and explore the data dynamically.
*   **Actionable Insights**: Deliver an Executive Summary report with data-backed recommendations for Q3 strategy.

## 4. Success Criteria
The project will be considered successful if:
*   Stakeholders can easily access KPI metrics via the Power BI dashboard.
*   Clear, data-driven recommendations are provided regarding discount caps and channel focus.
*   The entire data pipeline is modular, documented, and reproducible.
