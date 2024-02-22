WITH application_packages AS (
    SELECT * FROM {{ source('staging', 'application_packages') }}
)

SELECT
    appid AS application_id,
    packageid AS package_id
FROM application_packages
WHERE
    packageid IS NOT NULL
    AND appid IS NOT NULL
