SELECT *
FROM hotel_bookings
LIMIT 5;

-- Q1: Which market segment generates the highest revenue?

-- Approach 1: Ranking by room count
SELECT market_segment, COUNT(*) AS room_count
FROM hotel_bookings
GROUP BY market_segment
ORDER BY room_count DESC
LIMIT 1;

-- Approach 2: Ranking by total revenue
SELECT market_segment, 
       ROUND(SUM(total_revenue)::numeric, 2) AS revenue
FROM hotel_bookings
GROUP BY market_segment
ORDER BY revenue DESC
LIMIT 1;


-- Q2: What is the average lead time for bookings?
SELECT AVG(lead_time) AS avg_lead_time
FROM hotel_bookings;


-- Q3: Which room types have the highest cancellation rates?
SELECT reserved_room_type,
       ROUND(SUM(is_canceled)::numeric / COUNT(*) * 100, 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY reserved_room_type
ORDER BY cancellation_rate DESC
LIMIT 1;


-- Q4: How many bookings were made per market segment?
SELECT market_segment, COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY market_segment
ORDER BY total_bookings DESC;


-- Q5: Distribution of bookings across customer types
SELECT customer_type, COUNT(*) AS customer_type_distribution
FROM hotel_bookings
GROUP BY customer_type
ORDER BY customer_type_distribution DESC;


-- Q6: Which room types generate the highest revenue?
SELECT assigned_room_type,
       ROUND(SUM(total_revenue)::numeric, 2) AS total_revenue
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY assigned_room_type
ORDER BY total_revenue DESC
LIMIT 1;


-- Q7: During which seasons is the revenue highest?
SELECT 
    CASE 
        WHEN EXTRACT(MONTH FROM arrival_date) IN (12, 1, 2) THEN 'Winter'
        WHEN EXTRACT(MONTH FROM arrival_date) IN (3, 4, 5) THEN 'Spring'
        WHEN EXTRACT(MONTH FROM arrival_date) IN (6, 7, 8) THEN 'Summer'
        WHEN EXTRACT(MONTH FROM arrival_date) IN (9, 10, 11) THEN 'Autumn'
    END AS season,
    ROUND(SUM(total_revenue)::numeric, 2) AS total_revenue
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY season
ORDER BY total_revenue DESC;


-- Q8: Which countries have the most bookings?
SELECT country, COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY country
ORDER BY total_bookings DESC
LIMIT 5;


-- Q9: Ratio of repeat vs new customers

-- Approach 1
SELECT 
    SUM(CASE WHEN is_repeated_guest = 1 THEN 1 ELSE 0 END) AS repeat_customers,
    SUM(CASE WHEN is_repeated_guest = 0 THEN 1 ELSE 0 END) AS new_customers,
    ROUND(
        SUM(CASE WHEN is_repeated_guest = 1 THEN 1 ELSE 0 END)::numeric /
        NULLIF(SUM(CASE WHEN is_repeated_guest = 0 THEN 1 ELSE 0 END), 0),
        2
    ) AS repeat_to_new_ratio
FROM hotel_bookings;


-- Approach 2 (subquery)
SELECT  
    repeat_customers,
    new_customers,
    ROUND(repeat_customers::numeric / NULLIF(new_customers, 0), 2) AS repeat_to_new_ratio
FROM (
    SELECT  
        SUM(CASE WHEN is_repeated_guest = 1 THEN 1 ELSE 0 END) AS repeat_customers,
        SUM(CASE WHEN is_repeated_guest = 0 THEN 1 ELSE 0 END) AS new_customers
    FROM hotel_bookings
) AS counts;


-- Q10: Monthly booking trends (chronological)

SELECT 
    TO_CHAR(DATE_TRUNC('month', arrival_date), 'Mon YYYY') AS booking_month,
    COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY DATE_TRUNC('month', arrival_date)
ORDER BY DATE_TRUNC('month', arrival_date);


-- Monthly ranking by booking volume
SELECT 
    TO_CHAR(DATE_TRUNC('month', arrival_date), 'Mon YYYY') AS booking_month,
    COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY DATE_TRUNC('month', arrival_date)
ORDER BY total_bookings DESC;