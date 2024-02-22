WITH player_count_1h AS (
    SELECT * FROM {{ source('staging', 'player_count_1h') }}
)

SELECT
    CAST(appid AS INT) AS application_id,
    'top_2000' AS application_rank,
    EXTRACT(DATE FROM time) AS count_date,
    DATE_TRUNC(time, HOUR) AS hour_start,
    playercount AS player_count
FROM player_count_1h
