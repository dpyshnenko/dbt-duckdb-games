{{ config(materialized='view') }}

WITH
player_count AS (SELECT * FROM {{ ref('int_player_count_union') }}),

information_games AS (SELECT * FROM {{ ref('stg_application_information') }})

SELECT
    CAST(player_count.application_id AS INT) AS application_id,
    player_count.date,
    player_count.rank,
    information_games.type,
    information_games.game_name,
    information_games.release_date,
    information_games.is_free_to_play,
    ROUND(AVG(player_count.player_count)) AS avg_num_player,
    MAX(player_count.player_count) AS max_num_player,
    MIN(player_count.player_count) AS min__num_player
FROM
    player_count
LEFT JOIN information_games
    ON
        player_count.application_id = information_games.application_id
GROUP BY 1, 2, 3, 4, 5, 6, 7
