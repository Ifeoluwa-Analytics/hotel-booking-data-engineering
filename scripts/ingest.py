import pandas as pd

# Define file path
file_path = "data/raw/hotel_bookings.csv"

# Load dataset
df = pd.read_csv(file_path)

# Basic inspection
print("Dataset Loaded Successfully!\n")

print("First 5 rows:")
print(df.head())

print("\nDataset Info:")
print(df.info())

print("\nMissing Values:")
print(df.isnull().sum())