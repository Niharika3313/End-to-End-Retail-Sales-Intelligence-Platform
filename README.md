# 📊 End-to-End Retail Sales Intelligence Platform

![Executive Overview Dashboard](images/executive_overview.png)

[![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![SQL](https://img.shields.io/badge/SQL-003B57?style=for-the-badge&logo=postgresql&logoColor=white)](#)
[![Excel](https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white)](#)

---

## 📝 Project Overview
This repository contains a production-grade, **End-to-End Data Analytics Pipeline** designed to solve complex retail business problems. 

It demonstrates my ability to navigate the entire data lifecycle: extracting raw Excel data, building automated Python ETL scripts, architecting SQL Data Warehouses, and ultimately delivering an interactive Power BI intelligence platform that analyzes over **$82.63 Million in sales**.

---
  
## 🏗️ System Architecture

```text
  [Excel Data]  Raw transactions (8,000+ rows)
       ↓
[Data Cleaning] Pandas / Power Query deduplication & imputation
       ↓
[SQL Analysis]  Aggregations, Window Functions, Cohort Analysis
       ↓
[Data Modeling] Star Schema architecture (Fact & Dim tables)
       ↓
[Power BI DB]   Interactive Dashboard & DAX calculations
       ↓
[Biz Insights]  Actionable strategy for C-Suite executives
```

---

## 📁 Repository Structure

### 1. 📘 Documentation (`docs/`)
Professional documentation outlining the business context and technical schema.
*   [`Business_Requirements.md`](docs/Business_Requirements.md): The stakeholder request and project scope.
*   [`Data_Dictionary.md`](docs/Data_Dictionary.md): Comprehensive schema detailing raw fields.
*   [`DAX_Measures.md`](docs/DAX_Measures.md): Explicit documentation of the DAX formulas driving the KPIs.

### 2. 🐍 Automated ETL (`scripts/` & `notebooks/`)
*   [`scripts/data_cleaning_pipeline.py`](scripts/data_cleaning_pipeline.py): A modular Python script handling missing values and feature engineering.
*   [`notebooks/Exploratory_Data_Analysis.ipynb`](notebooks/Exploratory_Data_Analysis.ipynb): Jupyter notebook containing Pandas profiling and Seaborn visualizations.

### 3. 💾 Advanced SQL (`sql/`)
Simulating a cloud data warehouse environment.
*   `01_table_creation.sql`: DDL and table design.
*   `02_data_exploration.sql`: Aggregations, Window Functions (`LAG` for MoM growth).
*   `03_advanced_analytics.sql`: **Cohort Analysis**, **7-Day Rolling Averages**, and **Pareto (80/20) Analysis**.

### 4. 📊 Power BI Dashboards (`dashboards/`)
The interactive front-end for business users.
*   Built using Star Schema data modeling and advanced DAX measures.
*   👉 **[View Dashboard Export (PDF)](dashboards/Dashboard_Export.pdf)** *(Placeholder: upload PDF here)*

### 5. 💡 Strategic Deliverables (`reports/`)
*   [`Recruiter_One_Page_Summary.md`](reports/Recruiter_One_Page_Summary.md): A concise 1-page summary of the entire project.
*   [`Executive_Summary.md`](reports/Executive_Summary.md): A comprehensive business report detailing findings on regional performance.

---

## 🖼️ Dashboard Walkthrough

### 1. Executive Overview
Focuses on high-level KPIs, overall profitability, and top-performing products.
<p align="center">
  <img src="images/executive_overview.png" alt="Executive Overview Dashboard" width="800">
</p>

### 2. Customer & Product Analysis
Deep dive into key accounts, margins by specific products, and cross-channel performance.
<p align="center">
  <img src="images/customer_analysis.png" alt="Customer & Product Dashboard" width="800">
</p>

---

## 🚀 Key Business Outcomes & Insights

1.  **In-Store Dominance**: Contrary to digital trends, **In-Store** sales drive the vast majority of our **$82.63M revenue**, massively outperforming Online and Wholesale channels.
2.  **Regional Performance Gap**: The **West** region generates the highest sales volume, while the **Northeast** records the lowest, highlighting a critical need for localized marketing interventions.
3.  **Profitability Mechanics**: Scatter plot analysis confirms a strong positive relationship between sales volume and profitability. High-volume items like **Accessories** maintain strong margins, while niche items like **Cocktail Glasses** yield the highest overall profit margin (40.27%).

---
*If you are a hiring manager or recruiter looking for a Data Analyst who can bridge the gap between technical data engineering and strategic business intelligence, please reach out!* 🚀
