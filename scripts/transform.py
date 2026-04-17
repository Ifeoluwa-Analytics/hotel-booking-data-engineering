import pandas as pd

# Load raw data
file_path = "data/raw/hotel_bookings.csv"
df = pd.read_csv(file_path)

print("Raw dataset loaded...\n")

# Check missing values
print("Missing values before cleaning:\n", df.isnull().sum())

# Handle missing values

# Fill 'children' with 0
df['children'] = df['children'].fillna(0)

# Fill 'country' with 'Unknown'
df['country'] = df['country'].fillna('Unknown')

# Drop rows where 'agent' or 'company' is missing (optional approach)
df['agent'] = df['agent'].fillna(0)
df['company'] = df['company'].fillna(0)

# Remove duplicates
df = df.drop_duplicates()

# Convert date columns

# Combine year, month, day into one column
df['arrival_date'] = pd.to_datetime(
    df['arrival_date_year'].astype(str) + '-' +
    df['arrival_date_month'] + '-' +
    df['arrival_date_day_of_month'].astype(str),
    errors='coerce'
)

# Create new useful columns

# Total guests
df['total_guests'] = df['adults'] + df['children'] + df['babies']

# Total nights stayed
df['total_nights'] = df['stays_in_weekend_nights'] + df['stays_in_week_nights']

# Total revenue (very important metric)
df['total_revenue'] = df['adr'] * df['total_nights']

# Drop unnecessary columns
columns_to_drop = [
    'arrival_date_year',
    'arrival_date_month',
    'arrival_date_day_of_month'
]

df = df.drop(columns=columns_to_drop)

# Final check
print("\nMissing values after cleaning:\n", df.isnull().sum())

print("\nCleaned dataset preview:")
print(df.head())

# Save cleaned data
output_path = "data/cleaned/cleaned_hotel_bookings.csv"
df.to_csv(output_path, index=False)

print(f"\nCleaned data saved to {output_path}")