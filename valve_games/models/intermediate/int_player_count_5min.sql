{{ config(materialized='view') }}

WITH hourly_aggregation AS (
    SELECT
        application_id,
        time AS time,
        -- Extracts the date from the timestamp
        rank,
        EXTRACT(DATE FROM time) AS date,
        DATE_TRUNC(time, HOUR) AS hour_start,
        AVG(player_count) AS avg_player_count
    FROM
        {{ ref('stg_player_count_5min') }}
    GROUP BY
        application_id,
        time,
        date,
        DATE_TRUNC(time, HOUR),
        rank
)

SELECT *
FROM
    hourly_aggregation
