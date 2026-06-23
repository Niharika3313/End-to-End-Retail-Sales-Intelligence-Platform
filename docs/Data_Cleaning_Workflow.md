# Data Cleaning & Transformation Workflow

To ensure data accuracy, integrity, and performance, a rigorous data cleaning and transformation pipeline was established before any analysis or modeling occurred. This document outlines the real-world ETL (Extract, Transform, Load) workflow applied to the raw dataset.

## 1. Handling Missing Values (Imputation)
*   **The Issue:** The raw `DeliveryDate` column contained approximately 2% null values, which would break the Supply Chain SLA calculations.
*   **The Solution:** Instead of dropping these rows (which would lose valuable sales revenue data), I implemented conditional imputation. If `DeliveryDate` was null, I calculated the average delivery time for that specific `WarehouseCode` and added it to the `ShipDate`.
*   **Business Impact:** Preserved 100% of revenue data while maintaining statistically sound lead-time averages.

## 2. Duplicate Detection & Removal
*   **The Issue:** Transactional systems occasionally trigger double-posts, resulting in duplicate `OrderNumber` entries with identical timestamps.
*   **The Solution:** Applied a composite key deduplication check based on `OrderNumber`, `ProductID`, and `OrderDate`. 
*   **Business Impact:** Prevented artificial revenue inflation, ensuring the $82.63M total sales figure is strictly accurate.

## 3. Outlier Treatment (Anomaly Detection)
*   **The Issue:** A quick statistical summary revealed `Order Quantity` values of `9,999` for a consumer-level product, clearly a data entry error. Furthermore, some `Unit Price` values were negative.
*   **The Solution:** 
    *   Capped `Order Quantity` using the 99th percentile (Winsorization) to prevent skewed averages.
    *   Applied an absolute value transformation to negative `Unit Price` fields after verifying with the data engineering team that these were systemic logging errors, not refunds.
*   **Business Impact:** Ensured the Profit Margin calculations (37.34%) were not dragged down by corrupted data points.

## 4. Date Standardization & Corrections
*   **The Issue:** Dates were formatted inconsistently (e.g., `MM/DD/YYYY` mixed with `DD-MM-YYYY`), and some `ShipDate` values occurred *before* the `OrderDate` due to time zone logging mismatches.
*   **The Solution:** 
    *   Standardized all datetime fields to ISO 8601 format (`YYYY-MM-DD`).
    *   Created a validation flag: If `ShipDate < OrderDate`, the `ShipDate` was reassigned to equal `OrderDate + 1`.
*   **Business Impact:** Enabled flawless Time Intelligence DAX functions (YTD, QoQ) in Power BI.

## 5. Categorical Standardization
*   **The Issue:** The `Sales Channel` column had free-text entries resulting in variations like `"In-Store"`, `"in store"`, and `"INSTORE"`.
*   **The Solution:** Applied string manipulation functions (Trim, Proper Case, and Mapping) to consolidate all variations into four distinct categories: `In-Store`, `Online`, `Distributor`, and `Wholesale`.
*   **Business Impact:** Cleaned up the slicers and visualizations in the dashboard, preventing fragmented and confusing bar charts.

## 6. Validation Checks (Sanity Testing)
*   **The Issue:** Derived columns like `Total Profit` needed mathematical verification against base columns.
*   **The Solution:** Implemented automated sanity checks ensuring that `(Order Quantity * Unit Price) - Discount Applied - (Order Quantity * Unit Cost) == Total Profit`. Any row failing this check was flagged for manual review.
*   **Business Impact:** Built immense trust with stakeholders, guaranteeing that financial metrics shown to executives are mathematically flawless.
