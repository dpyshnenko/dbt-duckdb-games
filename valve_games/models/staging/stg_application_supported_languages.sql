WITH application_supported_languages AS (
    SELECT * FROM {{ source('staging', 'application_supported_languages') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['appId', 'language']) }} AS language_id,
    appId AS application_id,
    language
FROM application_supported_languages
WHERE
    language IS NOT NULL
    AND appId IS NOT NULL
    AND TRIM(language) != ''
