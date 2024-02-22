{{ config(materialized='table') }}

SELECT
    ph.application_id,
    ai.game_name,
    ai.application_type,
    ai.release_date,
    ai.is_free_to_play,
    AVG(ph.final_price) AS avg_final_price,
    AVG(ph.discount) AS avg_discount,
    AVG(pc.player_count) AS avg_player_count
FROM {{ ref('fct_games_price_history') }} AS ph
JOIN {{ ref('fct_player_count_day_agg') }} AS pc
    ON ph.application_id = pc.application_id
JOIN {{ ref('dim_application_information') }} AS ai
    ON ph.application_id = ai.application_id
GROUP BY 1, 2, 3, 4, 5
