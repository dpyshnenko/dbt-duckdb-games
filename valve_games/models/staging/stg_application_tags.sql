WITH application_tags AS (
    SELECT * FROM {{ source('staging', 'application_tags') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['appId', 'tag']) }} AS tag_id,
    appId AS application_id,
    tag
FROM application_tags
WHERE
    tag IS NOT NULL
    AND appId IS NOT NULL
    AND TRIM(tag) != ''
