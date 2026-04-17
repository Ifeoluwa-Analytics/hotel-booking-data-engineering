import pandas as pd
import psycopg2

# Load cleaned data
df = pd.read_csv("data/cleaned/cleaned_hotel_bookings.csv")

print("Cleaned data loaded:", df.shape)

# Connect to PostgreSQL
conn = psycopg2.connect(
    host="localhost",
    database="hotel_booking_db",
    user="postgres",
    password="0915"   
)

cursor = conn.cursor()

# Insert data row by row
columns = [
    "hotel", "is_canceled", "lead_time", "arrival_date",
    "stays_in_weekend_nights", "stays_in_week_nights",
    "adults", "children", "babies", "meal", "country",
    "market_segment", "distribution_channel",
    "is_repeated_guest", "previous_cancellations",
    "previous_bookings_not_canceled", "reserved_room_type",
    "assigned_room_type", "booking_changes", "deposit_type",
    "agent", "company", "days_in_waiting_list", "customer_type",
    "adr", "required_car_parking_spaces",
    "total_of_special_requests", "reservation_status",
    "reservation_status_date", "total_guests",
    "total_nights", "total_revenue"
]

df = df[columns]

for _, row in df.iterrows():
    cursor.execute("""
        INSERT INTO hotel_bookings (
            hotel, is_canceled, lead_time, arrival_date,
            stays_in_weekend_nights, stays_in_week_nights,
            adults, children, babies, meal, country,
            market_segment, distribution_channel,
            is_repeated_guest, previous_cancellations,
            previous_bookings_not_canceled, reserved_room_type,
            assigned_room_type, booking_changes, deposit_type,
            agent, company, days_in_waiting_list, customer_type,
            adr, required_car_parking_spaces,
            total_of_special_requests, reservation_status,
            reservation_status_date, total_guests,
            total_nights, total_revenue
        )
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, tuple(row))
    
# Commit changes
conn.commit()

# Close connection
cursor.close()
conn.close()

print("Data successfully loaded into PostgreSQL!")