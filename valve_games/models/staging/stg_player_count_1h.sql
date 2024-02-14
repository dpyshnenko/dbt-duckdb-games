{{
    config(
        materialized='view'
    )
}}

with

player_count_1h as (
    select * from {{ source('staging', 'player_count_1h') }}
)

select
    time as time,
    'top_2000' as rank,
    -- Extracts the date from the timestamp
    playercount as player_count,
    -- Extracts the hour from the timestamp
    CAST(appid as INT) as application_id,
    -- Indicates this row is for a top 2000 application
    EXTRACT(date from time) as date,
    DATE_TRUNC(time, hour) as hour
from player_count_1h
