-- Step 1: Create the individual tables for each month (Example for January)
-- This process was repeated for 202501 through 202512 using pgAdmin import tool
/*
CREATE TABLE public.ride_202501 (
    ride_id text, 
    rideable_type text, 
    started_at timestamp without time zone, 
    ended_at timestamp without time zone, 
    start_station_name text, 
    start_station_id text, 
    end_station_name text, 
    end_station_id text, 
    start_lat numeric, 
    start_lng numeric, 
    end_lat numeric, 
    end_lng numeric, 
    member_casual text, 
    PRIMARY KEY (ride_id)
);
ALTER TABLE IF EXISTS public.ride_202501 OWNER to postgres;
*/

-- Step 2: Combine all 12 months of imported CSV data into a single master table
CREATE TABLE ride_2025 AS
SELECT * FROM ride_202501 UNION ALL
SELECT * FROM ride_202502 UNION ALL
SELECT * FROM ride_202503 UNION ALL
SELECT * FROM ride_202504 UNION ALL
SELECT * FROM ride_202505 UNION ALL
SELECT * FROM ride_202506 UNION ALL
SELECT * FROM ride_202507 UNION ALL
SELECT * FROM ride_202508 UNION ALL
SELECT * FROM ride_202509 UNION ALL
SELECT * FROM ride_202510 UNION ALL
SELECT * FROM ride_202511 UNION ALL
SELECT * FROM ride_202512;
