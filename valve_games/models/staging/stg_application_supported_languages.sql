{{
    config(
        materialized='view'
    )
}}

with

application_supported_languages as (
    select * from {{ source('staging', 'application_supported_languages')}}
)

select
    {{ dbt_utils.generate_surrogate_key(['appId', 'language']) }} as language_id,
    appId as application_id,
    language,
from application_supported_languages
WHERE language IS NOT NULL
AND appId IS NOT NULL
AND TRIM(language) <> ''