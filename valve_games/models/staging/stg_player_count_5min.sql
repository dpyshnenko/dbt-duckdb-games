{{
    config(
        materialized='view'
    )
}}

with

player_count_5min as (
    select * from {{ source('staging', 'player_count_5min')}}
)

select
    CAST(AppId AS INT) AS application_id,
    Time as time,
    -- Extracts the date from the timestamp
    EXTRACT(DATE FROM Time) as date,
    -- Extracts the hour from the timestamp
    EXTRACT(HOUR FROM Time) as hour,
    PlayerCount as player_count,
    'top_1000' as rank  -- Indicates this row is for a top 1000 application
from player_count_5min

