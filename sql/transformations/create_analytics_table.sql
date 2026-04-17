CREATE TABLE hotel_revenue_summary AS
SELECT 
    hotel,
    COUNT(*) AS total_bookings,
    SUM(total_revenue) AS total_revenue,
    AVG(total_revenue) AS avg_revenue_per_booking
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY hotel;

CREATE TABLE monthly_booking_trends AS
SELECT 
    DATE_TRUNC('month', arrival_date) AS booking_month,
    COUNT(*) AS total_bookings,
    SUM(total_revenue) AS total_revenue
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY booking_month
ORDER BY booking_month;

CREATE TABLE market_segment_performance AS
SELECT 
    market_segment,
    COUNT(*) AS total_bookings,
    SUM(total_revenue) AS total_revenue,
    AVG(total_nights) AS avg_stay_duration,
    SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS cancellation_rate
FROM hotel_bookings
GROUP BY market_segment;

CREATE TABLE customer_behavior_summary AS
SELECT 
    customer_type,
    COUNT(*) AS total_bookings,
    AVG(total_nights) AS avg_stay,
    SUM(total_revenue) AS total_revenue
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY customer_type;

CREATE TABLE country_performance AS
SELECT 
    country,
    COUNT(*) AS total_bookings,
    SUM(total_revenue) AS total_revenue
FROM hotel_bookings
GROUP BY country
ORDER BY total_bookings DESC;