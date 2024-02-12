{{
    config(
        materialized='view'
    )
}}

with

price_history as (
    select * from {{ source('staging', 'price_history')}}
)

select
    {{ dbt_utils.generate_surrogate_key(['AppId', 'Date']) }} as price_history_id,
    AppId as application_id,
    Date as date,
    InitialPrice as initial_price,
    FinalPrice as final_price,
    Discount as discount
from price_history

