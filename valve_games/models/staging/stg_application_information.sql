{{
    config(
        materialized='view'
    )
}}

with

application_information as (
    select * from {{ source('staging', 'application_information')}}
)

select
    {{ dbt_utils.generate_surrogate_key(['appId', 'name']) }} as game_id,
    appId as application_id,
    type,
    name as game_name,
    releasedate as release_date,
    freetoplay as is_free_to_play,
from application_information
