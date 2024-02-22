{{ config(materialized='table') }}

SELECT
    g.game_genre,
    AVG(ph.initial_price) AS avg_price,
    AVG(pc.player_count) AS avg_player_count,
    COUNT(DISTINCT pc.application_id) AS game_count
FROM {{ ref('dim_application_genres') }} AS g
JOIN {{ ref('fct_player_count_day_agg') }} AS pc
    ON
        g.application_id = pc.application_id
JOIN {{ ref('fct_games_price_history') }} AS ph
    ON
        g.application_id = ph.application_id
GROUP BY g.game_genre
