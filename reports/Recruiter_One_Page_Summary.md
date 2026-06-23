# Recruiter Summary: Retail Sales Intelligence Platform

**Candidate:** Niharika Sharma | **Role:** Data Analyst / BI Developer  
**Project:** End-to-End Retail Sales Analytics Pipeline

---

## 📌 The Problem
Executive leadership lacked visibility into multi-channel sales performance across $82M in revenue. Reporting was siloed in 8,000+ raw Excel transactions, resulting in delayed decision-making, an inability to identify regional performance gaps, and undetected profit cannibalization caused by aggressive discounting strategies.

## 🗄️ The Dataset
*   **Size:** ~8,000 retail sales transactions (May 2018 - Dec 2020).
*   **Structure:** Relational data model consisting of a central Sales Fact table and 4 Dimension tables (Customers, Products, Locations, Channels).
*   **Key Metrics:** Order Quantity, Unit Price, Unit Cost, Discount Applied, Delivery SLA.

## 📊 Dashboard Overview
An interactive Power BI platform designed for C-Suite executives, enabling top-down analysis of revenue, regional splits, and product-level profitability.

![Executive Overview](../images/executive_overview.png)

## 💡 Key Business Insights
1.  **In-Store Dominance:** Despite digital trends, the **In-Store** channel drives the vast majority of the $82.63M revenue, massively outperforming Online and Wholesale channels.
2.  **Regional Polarization:** The **West** region generates nearly double the sales volume of the Northeast region.
3.  **Profitability Mechanics:** High-volume items like *Accessories* maintain strong margins, but niche items like *Cocktail Glasses* yield the highest specific profit margin (40.27%).
4.  **Discount Inefficiency:** Analysis revealed that offering discounts >50% artificially inflates volume but actively cannibalizes net profit.

## 🎯 Strategic Recommendations
1.  **Cap Discounts at 30%:** Implement a hard cap on promotional discounts to protect the company's baseline 37.34% profit margin.
2.  **Northeast Revitalization:** Shift 15% of the localized marketing budget into the Northeast region to close the massive gap compared to the West.
3.  **Bundle High-Margin SKUs:** Initiate cross-selling campaigns pairing *Accessories* (highest volume) with *Cocktail Glasses* (highest margin) to maximize cart profitability.

## 🛠️ Technical Skills Demonstrated
*   **Data Cleaning & ETL:** Pandas, Power Query (Imputation, Deduplication, Outlier Winsorization).
*   **Advanced SQL:** Window Functions, Cohort Analysis, Aggregations.
*   **Data Modeling:** Star Schema architecture, Fact vs. Dimension logic.
*   **Advanced DAX:** `CALCULATE`, `TOTALYTD`, `SAMEPERIODLASTYEAR`, `DIVIDE`.
*   **Data Visualization:** UI/UX design, custom tooltips, drill-throughs, Power BI.
