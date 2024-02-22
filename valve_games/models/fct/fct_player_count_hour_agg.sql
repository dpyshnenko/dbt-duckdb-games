WITH player_count_hour_agg AS (

    SELECT * FROM {{ ref('stg_player_count_1h') }}
    UNION ALL
    SELECT * FROM {{ ref('int_player_count_5min_agg') }}

)

SELECT * FROM player_count_hour_agg
