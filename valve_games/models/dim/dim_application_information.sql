WITH dim_application_information AS (
    SELECT * FROM {{ ref('stg_application_information') }}
)

SELECT
    CAST(application_id AS INT) AS application_id,
    application_type,
    game_name,
    release_date,
    is_free_to_play
FROM dim_application_information
