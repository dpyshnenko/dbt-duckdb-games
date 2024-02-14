{{
    config(
        materialized='view'
    )
}}

with

application_tags as (
    select * from {{ source('staging', 'application_tags')}}
)

select
    {{ dbt_utils.generate_surrogate_key(['appId', 'tag']) }} as tag_id,
    appId as application_id,
    tag,
from application_tags
WHERE tag IS NOT NULL
AND appId IS NOT NULL
AND TRIM(tag) <> ''