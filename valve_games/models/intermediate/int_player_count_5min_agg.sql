WITH hourly_aggregation AS (
    SELECT
        application_id,
        -- Extracts the date from the timestamp
        application_rank,
        EXTRACT(DATE FROM count_time) AS count_date,
        DATE_TRUNC(count_time, HOUR) AS hour_start,
        AVG(player_count) AS avg_player_count
    FROM
        {{ ref('stg_player_count_5min') }}
    GROUP BY
        application_id,
        count_date,
        DATE_TRUNC(count_time, HOUR),
        application_rank
)

SELECT * FROM hourly_aggregation
