WITH player_count_5min AS (
    SELECT * FROM {{ source('staging', 'player_count_5min') }}
)

SELECT
    CAST(appid AS INT) AS application_id,
    time AS count_time,
    playercount AS player_count,
    -- Extracts the date from the timestamp
    'top_1000' AS application_rank,
    -- Extracts the hour from the timestamp
    EXTRACT(DATE FROM time) AS count_date,
    -- Indicates this row is for a top 1000 application
    EXTRACT(HOUR FROM time) AS count_hour
FROM player_count_5min
