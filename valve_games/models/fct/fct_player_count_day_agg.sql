WITH player_count_hour_agg AS (

    SELECT * FROM {{ ref('stg_player_count_1h') }}
    UNION ALL
    SELECT * FROM {{ ref('int_player_count_5min_agg') }}

)

SELECT
    application_id,
    application_rank,
    count_date,
    AVG(player_count) AS player_count
FROM
    player_count_hour_agg
GROUP BY 1, 2, 3
