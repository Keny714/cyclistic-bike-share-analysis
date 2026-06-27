-- Step 3: Clean the combined data and save it as a final working table
-- This query handles null values, trims whitespace, calculates duration, and filters outliers.

CREATE TABLE cyclistic_2025 AS (
	WITH CLEAN_DATA AS (
		SELECT
			RIDE_ID,
			RIDEABLE_TYPE,
			STARTED_AT,
			ENDED_AT,
            -- Calculate ride duration to easily filter out bad data later
			ENDED_AT - STARTED_AT AS RIDE_DURATION,
			TRIM(START_STATION_NAME) AS START_STATION_NAME,
			TRIM(START_STATION_ID) AS START_STATION_ID,
			TRIM(END_STATION_NAME) AS END_STATION_NAME,
			TRIM(END_STATION_ID) AS END_STATION_ID,
            -- Extract properly formatted month and day names for time-based analysis
			TRIM(TO_CHAR(STARTED_AT, 'Month')) AS MONTH_NAME,
			TRIM(TO_CHAR(STARTED_AT, 'Day')) AS DAY_NAME,
            MEMBER_CASUAL
		FROM
			RIDE_2025
		WHERE
            -- Remove missing station data primarily caused by dockless e-bikes locked outside of official zones
			RIDE_ID IS NOT NULL
			AND STARTED_AT IS NOT NULL
			AND ENDED_AT IS NOT NULL
			AND START_STATION_NAME IS NOT NULL
			AND END_STATION_NAME IS NOT NULL
	)
    SELECT
        *
    FROM
        CLEAN_DATA
    WHERE
        -- 1. Remove rides that are 1 minute or shorter (False Starts, testing bikes, accidental unlocks)
        RIDE_DURATION > INTERVAL '1 minutes'
        -- 2. Remove rides that are longer than 24 hours (Outliers, stolen bikes, maintenance)
        AND RIDE_DURATION < INTERVAL '24 hours'
);
