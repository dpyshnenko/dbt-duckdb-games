{{ config(materialized='view') }}

WITH application_information AS (
    SELECT
        a.application_id,
        a.type,
        a.game_name,
        a.release_date,
        a.is_free_to_play,
        ARRAY_AGG(DISTINCT g.game_genre) AS genres,
        ARRAY_AGG(DISTINCT t.tag) AS tags,
        ARRAY_AGG(DISTINCT l.language) AS supported_languages,
        ARRAY_AGG(DISTINCT d.developer_name) AS developers,
        ARRAY_AGG(DISTINCT pub.publisher_name) AS publishers
    FROM {{ ref('stg_application_information') }} AS a
    LEFT JOIN
        {{ ref('stg_application_genres') }} AS g
        ON a.application_id = g.application_id
    LEFT JOIN
        {{ ref('stg_application_tags') }} AS t
        ON a.application_id = t.application_id
    LEFT JOIN
        {{ ref('stg_application_supported_languages') }} AS l
        ON a.application_id = l.application_id
    LEFT JOIN
        {{ ref('stg_application_developers') }} AS d
        ON a.application_id = d.application_id
    LEFT JOIN
        {{ ref('stg_application_publishers') }} AS pub
        ON a.application_id = pub.application_id
    GROUP BY
        a.application_id, a.type, a.game_name, a.release_date, a.is_free_to_play
)

SELECT * FROM application_information
