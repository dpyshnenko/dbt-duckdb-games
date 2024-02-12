{{ config(materialized='view') }}

WITH hourly_aggregation AS (
  SELECT
    application_id,
    rank,
    DATE_TRUNC(time, HOUR) AS hour_start,
    AVG(player_count) AS avg_player_count
  FROM
    {{ ref('stg_player_count_5min') }}
  GROUP BY
    application_id,
    rank,
    DATE_TRUNC(time, HOUR)
)

SELECT
  *
FROM
  hourly_aggregation
