{{ config(materialized='table') }}

WITH genre_counts AS (
    SELECT
        game_genre,
        COUNT(*) AS genre_count
    FROM {{ ref('dim_application_genres') }}
    GROUP BY game_genre
)

SELECT
    game_genre,
    genre_count
FROM genre_counts
ORDER BY genre_count DESC
