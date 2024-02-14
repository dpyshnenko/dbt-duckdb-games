{{
    config(
        materialized='view'
    )
}}

with

player_count_5min as (
    select * from {{ source('staging', 'player_count_5min') }}
)

select
    time as time,
    playercount as player_count,
    -- Extracts the date from the timestamp
    'top_1000' as rank,
    -- Extracts the hour from the timestamp
    CAST(appid as INT) as application_id,
    EXTRACT(date from time) as date,
    -- Indicates this row is for a top 1000 application
    EXTRACT(hour from time) as hour
from player_count_5min
