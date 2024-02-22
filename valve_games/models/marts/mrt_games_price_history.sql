{{ config(materialized='view') }}

WITH
price_history AS (SELECT * FROM {{ ref('fct_games_price_history') }}),

information_games AS (SELECT * FROM {{ ref('dim_application_information') }})

SELECT
    price_history.price_date,
    price_history.initial_price,
    price_history.final_price,
    price_history.discount,
    price_history.application_id,
    information_games.application_type,
    information_games.game_name,
    information_games.release_date,
    information_games.is_free_to_play
FROM
    price_history
LEFT JOIN information_games ON
    price_history.application_id = information_games.application_id
