WITH application_information AS (
    SELECT * FROM {{ source('staging', 'application_information') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['appId', 'name']) }} AS game_id,
    appId AS application_id,
    type AS application_type,
    name AS game_name,
    releasedate AS release_date,
    COALESCE(freetoplay, 1) AS is_free_to_play
FROM application_information
