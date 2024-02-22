WITH application_publishers AS (
    SELECT * FROM {{ source('staging', 'application_publishers') }}
)

SELECT
    appid AS application_id,
    publisher AS publisher_name
FROM application_publishers
WHERE
    publisher IS NOT NULL
    AND appid IS NOT NULL
    AND TRIM(publisher) != ''
