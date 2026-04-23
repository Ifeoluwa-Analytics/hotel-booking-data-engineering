import pandas as pd
from pathlib import Path

# ==============================
# Utility Function (Reusable)
# ==============================
def save_with_backup(df, base_path, max_tries=10):
    path = Path(base_path)
    path.parent.mkdir(parents=True, exist_ok=True)  # Ensure folder exists

    for i in range(1, max_tries + 1):
        output_path = path.with_suffix('.csv')

        if i > 1:
            output_path = output_path.with_stem(f"{path.stem}_{i}")

        try:
            df.to_csv(output_path, index=False)
            print(f"Saved: {output_path}")
            return True

        except PermissionError:
            # File is likely open or locked → try next version
            continue

        except Exception as e:
            print(f"Unexpected error: {e}")
            return False

    print("Failed after all attempts!")
    return False


# ==============================
#  Extract
# ==============================
file_path = "data/raw/hotel_bookings.csv"

try:
    df = pd.read_csv(file_path)
    print("Raw dataset loaded...\n")
except Exception as e:
    print(f"Error loading data: {e}")
    exit()


# ==============================
#  Inspect
# ==============================
print("Missing values before cleaning:\n", df.isnull().sum())


# ==============================
# Transform
# ==============================

# Handle missing values
df['children'] = df['children'].fillna(0)
df['country'] = df['country'].fillna('Unknown')
df['agent'] = df['agent'].fillna(0)
df['company'] = df['company'].fillna(0)

# Remove duplicates
df = df.drop_duplicates()

# Convert date columns
df['arrival_date'] = pd.to_datetime(
    df['arrival_date_year'].astype(str) + '-' +
    df['arrival_date_month'] + '-' +
    df['arrival_date_day_of_month'].astype(str),
    errors='coerce'
)

# Feature engineering
df['total_guests'] = df['adults'] + df['children'] + df['babies']
df['total_nights'] = df['stays_in_weekend_nights'] + df['stays_in_week_nights']
df['total_revenue'] = df['adr'] * df['total_nights']

# Drop unnecessary columns
df = df.drop(columns=[
    'arrival_date_year',
    'arrival_date_month',
    'arrival_date_day_of_month'
])


# ==============================
# Final Check
# ==============================
print("\nMissing values after cleaning:\n", df.isnull().sum())

print("\nCleaned dataset preview:")
print(df.head())


# ==============================
# Load (Save Safely)
# ==============================
save_with_backup(df, "data/cleaned/cleaned_hotel_bookings")