{{ config(materialized='table') }}

WITH application_info AS (
    SELECT
        application_id,
        is_free_to_play
    FROM {{ ref('dim_application_information') }}
),

application_genres AS (
    SELECT
        application_id,
        game_genre
    FROM {{ ref('dim_application_genres') }}
),

player_counts AS (
    SELECT
        application_id,
        count_date,
        player_count
    FROM {{ ref('fct_player_count_hour_agg') }}
),

-- Combine the genres with the player counts first
genre_player_counts AS (
    SELECT
        pc.application_id,
        pc.count_date,
        ag.game_genre,
        pc.player_count
    FROM player_counts AS pc
    INNER JOIN application_genres AS ag ON pc.application_id = ag.application_id
),

-- Aggregate the average player count per genre, per is_free_to_play, per day
avg_player_count_by_genre AS (
    SELECT
        gpc.count_date,
        ai.is_free_to_play,
        gpc.game_genre,
        AVG(gpc.player_count) AS avg_play_count
    FROM genre_player_counts AS gpc
    INNER JOIN application_info AS ai ON gpc.application_id = ai.application_id
    GROUP BY gpc.count_date, ai.is_free_to_play, gpc.game_genre
)

SELECT
    count_date,
    is_free_to_play,
    game_genre,
    avg_play_count
FROM avg_player_count_by_genre
ORDER BY count_date, is_free_to_play, game_genre
