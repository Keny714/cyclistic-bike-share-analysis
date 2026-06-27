-- ==============================================================================
-- CYCLISTIC DATA ANALYSIS: 10 KEY BUSINESS QUESTIONS
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. What is the grand total number of rides in the entire clean dataset?
-- ------------------------------------------------------------------------------
SELECT
    COUNT(*) AS total_rides
FROM
    cyclistic_2025;

/* 
OUTPUT: 
3,661,540 total rides
*/

-- ------------------------------------------------------------------------------
-- 2. How many rides were taken on classic_bike compared to electric_bike?
-- ------------------------------------------------------------------------------
SELECT
    rideable_type,
    COUNT(rideable_type) AS total_rides
FROM
    cyclistic_2025
GROUP BY
    rideable_type;

/* 
OUTPUT: 
"classic_bike"  : 1,942,280 
"electric_bike" : 1,719,260
*/

-- ------------------------------------------------------------------------------
-- 3. What was the absolute longest ride_duration recorded in the year?
-- ------------------------------------------------------------------------------
SELECT
    MAX(ride_duration) AS longest_ride
FROM
    cyclistic_2025;

/* 
OUTPUT: 
"23:59:58.557" 
*/

-- ------------------------------------------------------------------------------
-- 4. Busiest Month: Which month of the year had the highest total number of rides?
-- ------------------------------------------------------------------------------
SELECT
    month_name,
    COUNT(*) AS no_of_rides
FROM
    cyclistic_2025
GROUP BY
    month_name
ORDER BY
    no_of_rides DESC;

/* 
OUTPUT: 
August has the highest number of rides in 2025 with 510,901, followed by July with 489,589.
*/

-- ------------------------------------------------------------------------------
-- 5. Slowest Day: Which day of the week had the lowest total number of rides?
-- ------------------------------------------------------------------------------
SELECT
    day_name,
    COUNT(*) AS no_of_rides
FROM
    cyclistic_2025
GROUP BY
    day_name
ORDER BY
    no_of_rides ASC;

/* 
OUTPUT: 
Sunday has the lowest number of rides with 470,068, followed by Monday at 499,311.
*/

-- ------------------------------------------------------------------------------
-- 6. Average Time by Bike: Do people take longer trips on classic bikes or electric bikes?
-- ------------------------------------------------------------------------------
SELECT
    rideable_type,
    AVG(ride_duration) AS average_ride_duration
FROM
    cyclistic_2025
GROUP BY
    rideable_type;

/* 
OUTPUT: 
People take longer trips on classic bikes. 
The average time for a classic bike is 18:57, whereas the average time for an electric bike is 12:41.
*/

-- ------------------------------------------------------------------------------
-- 7. Weekend: How many rides did Casual riders take on Saturday and Sunday combined? 
-- ------------------------------------------------------------------------------
SELECT
    COUNT(*) AS total_weekend_casual_rides
FROM
    cyclistic_2025
WHERE
    day_name IN ('Saturday', 'Sunday')
    AND member_casual = 'casual';

/* 
OUTPUT: 
The total number of rides by casual riders on the weekend in 2025 is 493,881.
*/

-- ------------------------------------------------------------------------------
-- 8. The Commuter Check: What is the average ride duration for Annual Members on weekdays?
-- ------------------------------------------------------------------------------
SELECT
    AVG(ride_duration) AS avg_weekday_member_duration
FROM
    cyclistic_2025
WHERE
    day_name IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
    AND member_casual = 'member';

/* 
OUTPUT: 
The average ride duration for annual members commuting on weekdays is 00:12:01.
*/

-- ------------------------------------------------------------------------------
-- 9. Top Member Destinations: What are the Top 5 most popular end stations for Annual Members?
-- ------------------------------------------------------------------------------
SELECT
    COUNT(end_station_name) AS no_of_rides,
    end_station_name
FROM
    cyclistic_2025
WHERE
    member_casual = 'member'
GROUP BY
    end_station_name
ORDER BY
    no_of_rides DESC
LIMIT 5;

/* 
OUTPUT: 
The top 5 end stations are Kingsbury St & Kinzie St, Clinton St & Washington Blvd, 
Clinton St & Madison St, Canal St & Madison St, and Clark St & Elm St. 
(Note: These are all major downtown transit hubs).
*/

-- ------------------------------------------------------------------------------
-- 10. The Most Popular Route: What is the single most popular route in the entire city?
-- ------------------------------------------------------------------------------
SELECT
    COUNT(*) AS total_trips,
    start_station_name,
    end_station_name
FROM
    cyclistic_2025
GROUP BY
    start_station_name,
    end_station_name
ORDER BY
    total_trips DESC
LIMIT 1;

/* 
OUTPUT: 
Start: "DuSable Lake Shore Dr & Monroe St" | End: "DuSable Lake Shore Dr & Monroe St"
This is a round-trip route, highly popular due to its location at the iconic Millennium Park and Navy Pier.
*/

-- ------------------------------------------------------------------------------
-- 11. The Morning vs. Evening Commute: What are the peak hours for Members vs Casuals?
-- ------------------------------------------------------------------------------
SELECT
    EXTRACT(HOUR FROM started_at) AS time_of_day,
    member_casual,
    COUNT(*) AS total_rides
FROM
    cyclistic_2025
GROUP BY
    time_of_day,
    member_casual
ORDER BY
    time_of_day ASC;

/* 
OUTPUT: 
Annual Members have two distinct daily spikes: 8:00 AM (177,865 rides) and 5:00 PM (258,588 rides), confirming they use the bikes for traditional 9-to-5 commuting.
Casual Riders do not have a morning commute spike; their usage slowly builds throughout the afternoon and peaks at 5:00 PM (126,347 rides).
*/