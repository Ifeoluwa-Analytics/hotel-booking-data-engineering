# Hotel Booking Data Engineering Project

## Project Overview

This project demonstrates an end-to-end **data engineering pipeline** built using Python and PostgreSQL. The goal is to ingest, transform, store, and analyze hotel booking data to generate meaningful business insights.

---

## Objectives
<<<<<<< HEAD

=======
>>>>>>> 1aa404666fa8b83794cdb748226871dcde424437
* Build a complete ETL pipeline (Extract, Transform, Load)
* Store structured data in a relational database
* Create transformation layers for analytics
* Generate business insights using SQL

---

## Tech Stack

* Python (Pandas, psycopg2)
* PostgreSQL
* SQL
* Visual Studio Code

---

## Architecture

The project follows a simple end-to-end data pipeline:

Kaggle Dataset → Python ETL → PostgreSQL → SQL Transformations → Analytics Layer

## Project Structure

```
hotel-booking-data-engineering/
│
├── data/
│   ├── raw/                  # Raw dataset from Kaggle
│   └── cleaned/              # Cleaned dataset after transformation
│
├── scripts/
│   ├── ingest.py             # Extract data
│   ├── transform.py          # Clean and transform data
│   └── load.py               # Load data into PostgreSQL
│
├── sql/
│   ├── analysis/             # Exploratory SQL queries
│   ├── analytics/            # Business insight queries
│   └── transformations/      # Data modeling & aggregated tables
│
├── README.md
└── requirements.txt
```

---

## Data Pipeline

### 1. Extract

* Dataset sourced from Kaggle
* Loaded into Python using Pandas

### 2. Transform

* Data cleaning (handling nulls, formatting)
* Feature engineering:

  * Total guests
  * Total nights
  * Total revenue

### 3. Load

* Data loaded into PostgreSQL database
* Table: `hotel_bookings`

---

## Data Engineering Focus

This project emphasizes building a structured ETL pipeline, transforming raw data into analytics-ready datasets stored in PostgreSQL.
---

## Data Modeling (Transformation Layer)

Created aggregated tables for analytics:

* `hotel_revenue_summary`
* `monthly_booking_trends`
* `market_segment_performance`
* `customer_behavior_summary`
* `country_performance`

These tables serve as the **analytics layer** for reporting and dashboards.

---

## Screenshots

### Database Output
![Database](images/database.png)

### SQL Query Results
![SQL Results](images/sql_results.png)

---

## Key Business Insights

* Identified top revenue-generating market segments
* Analyzed booking trends over time
* Evaluated cancellation rates across customer segments
* Compared performance across countries and customer types

---

## How to Run the Project

1. Clone the repository
2. Install dependencies:

   ```
   pip install -r requirements.txt
   ```
3. Run pipeline scripts:

   ```
   python scripts/ingest.py
   python scripts/transform.py
   python scripts/load.py
   ```
4. Execute SQL queries in PostgreSQL (pgAdmin)

---

## Data Flow

Kaggle Dataset → Python ETL → PostgreSQL → SQL Transformations → Business Insights

---

## Future Improvements

* Automate pipeline using Apache Airflow
* Build dashboard using Power BI
* Optimize data loading using bulk insert methods
* Implement advanced data modeling (fact & dimension tables)

---

## Author

Ifeoluwa Melody Olaloye

---
