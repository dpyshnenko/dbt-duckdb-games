{{
    config(
        materialized='view'
    )
}}

with

application_publishers as (
    select * from {{ source('staging', 'application_publishers')}}
)

select
    {{ dbt_utils.generate_surrogate_key(['appId', 'publisher']) }} as publisher_id,
    appId as application_id,
    publisher as publisher_name,
from application_publishers
