{{ config(materialized='table') }}

WITH language_counts AS (
    SELECT
        language,
        COUNT(*) AS lang_count
    FROM {{ ref('stg_application_supported_languages') }}
    GROUP BY language
)

SELECT
    language,
    lang_count
FROM language_counts
ORDER BY lang_count DESC
