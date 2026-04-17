-- Total Revenue by Hotel
SELECT hotel, SUM(total_revenue) AS total_revenue
FROM hotel_bookings
GROUP BY hotel
ORDER BY total_revenue DESC;

-- Cancellation Rate
SELECT 
    COUNT(*) FILTER (WHERE is_canceled = 1) * 100.0 / COUNT(*) AS cancellation_rate
FROM hotel_bookings;

-- Top Countries
SELECT country, COUNT(*) AS bookings
FROM hotel_bookings
GROUP BY country
ORDER BY bookings DESC
LIMIT 10;