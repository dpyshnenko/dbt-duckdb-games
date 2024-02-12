{{
    config(
        materialized='view'
    )
}}

with

application_developers as (
    select * from {{ source('staging', 'application_developers')}}
)

select
    {{ dbt_utils.generate_surrogate_key(['appId', 'developer']) }} as developer_id,
    appId as application_id,
    developer as developer_name
from application_developers
