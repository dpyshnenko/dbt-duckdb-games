WITH application_developers AS (
    SELECT * FROM {{ source('staging', 'application_developers') }}
)

SELECT
    appid AS application_id,
    developer AS developer_name
FROM application_developers
WHERE
    developer IS NOT NULL
    AND appid IS NOT NULL
    AND TRIM(developer) != ''
