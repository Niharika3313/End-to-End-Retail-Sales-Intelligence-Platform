import pandas as pd
import logging
import os

# Set up logging for the ETL pipeline
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def extract_data(file_path):
    """Extract data from the raw Excel file."""
    logging.info(f"Extracting data from {file_path}...")
    try:
        df = pd.read_excel(file_path)
        logging.info(f"Successfully loaded {len(df)} rows.")
        return df
    except Exception as e:
        logging.error(f"Error loading data: {e}")
        raise

def transform_data(df):
    """Clean data and engineer new features for analysis."""
    logging.info("Starting data transformation...")
    
    # 1. Handle missing values (Example: fill missing delivery dates with ship date + 2 days)
    # In a real scenario, this would depend on business logic.
    if df['DeliveryDate'].isnull().any():
        logging.info("Imputing missing DeliveryDates.")
        df['DeliveryDate'].fillna(df['ShipDate'] + pd.Timedelta(days=2), inplace=True)
        
    # 2. Feature Engineering
    logging.info("Calculating Total Revenue, Cost, and Profit...")
    df['Total_Revenue'] = (df['Order Quantity'] * df['Unit Price']) - df['Discount Applied']
    df['Total_Cost'] = df['Order Quantity'] * df['Unit Cost']
    df['Total_Profit'] = df['Total_Revenue'] - df['Total_Cost']
    
    logging.info("Calculating Delivery SLA metrics...")
    df['Delivery_Days'] = (df['DeliveryDate'] - df['OrderDate']).dt.days
    
    # 3. Clean column names for SQL compatibility (replace spaces with underscores)
    df.columns = [col.replace(' ', '_').replace('-', '_') for col in df.columns]
    
    logging.info("Transformation complete.")
    return df

def load_data(df, output_path):
    """Load the transformed data into a format ready for the SQL Data Warehouse / Power BI."""
    logging.info(f"Loading transformed data to {output_path}...")
    try:
        # Saving as CSV for faster ingestion by DB/PowerBI in production
        df.to_csv(output_path, index=False)
        logging.info("Data successfully exported.")
    except Exception as e:
        logging.error(f"Error exporting data: {e}")
        raise

if __name__ == "__main__":
    # Define file paths
    RAW_DATA_PATH = '../data/Cardenality_Sales_Data.xlsx'
    CLEAN_DATA_PATH = '../data/Cleaned_Sales_Data.csv'
    
    # Execute ETL Pipeline
    logging.info("=== Starting ETL Pipeline ===")
    
    # Check if data file exists
    if not os.path.exists(RAW_DATA_PATH):
        logging.error(f"Raw data file not found at {RAW_DATA_PATH}. Please ensure it is in the data/ folder.")
    else:
        raw_df = extract_data(RAW_DATA_PATH)
        clean_df = transform_data(raw_df)
        load_data(clean_df, CLEAN_DATA_PATH)
        
        logging.info("=== ETL Pipeline Finished Successfully ===")
