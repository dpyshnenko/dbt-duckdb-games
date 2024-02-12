{{ config(materialized='view') }}

WITH
    price_hisory AS ( SELECT * FROM {{ ref('stg_price_history') }} ),
    information_games AS ( SELECT * FROM {{ ref('stg_application_information') }} )

SELECT
    CAST(price_hisory.application_id AS INT64) AS application_id,
    price_hisory.date,
    price_hisory.initial_price,
    price_hisory.final_price,
    price_hisory.discount,
    information_games.type,
    information_games.game_name,
    information_games.release_date,
    information_games.is_free_to_play
FROM
    price_hisory
    LEFT JOIN information_games ON
        price_hisory.application_id = information_games.application_id