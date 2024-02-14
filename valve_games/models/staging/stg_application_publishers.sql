{{
    config(
        materialized='view'
    )
}}

with

application_publishers as (
    select * from {{ source('staging', 'application_publishers') }}
)

select
    appid as application_id,
    publisher as publisher_name
from application_publishers
where
    publisher is not NULL
    and appid is not NULL
    and TRIM(publisher) != ''
