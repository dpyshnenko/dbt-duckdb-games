WITH application_genres AS (
    SELECT * FROM {{ source('staging', 'application_genres') }}
)

SELECT
    appid AS application_id,
    genre AS game_genre
FROM application_genres
WHERE
    genre IS NOT NULL
    AND appid IS NOT NULL
    AND TRIM(genre) != ''
