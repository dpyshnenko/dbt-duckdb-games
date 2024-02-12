{{
    config(
        materialized='view'
    )
}}

with

application_packages as (
    select * from {{ source('staging', 'application_packages')}}
)

select
    appId as application_id,
    packageid as package_id,
from application_packages
