{{ config(materialized='view') }}

WITH concatenated_data AS (

    SELECT * FROM {{ ref('stg_player_count_1h') }}
    UNION ALL
    SELECT * FROM {{ ref('int_player_count_5min') }}

)

SELECT * FROM concatenated_data
