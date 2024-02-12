{{
    config(
        materialized='view'
    )
}}

with

player_count_1h as (
    select * from {{ source('staging', 'player_count_1h')}}
)

select
    CAST(AppId AS INT) AS application_id,
    Time as time,
    -- Extracts the date from the timestamp
    EXTRACT(DATE FROM Time) as date,
    -- Extracts the hour from the timestamp
    EXTRACT(HOUR FROM Time) as hour,
    PlayerCount as player_count,
    'top_2000' as rank  -- Indicates this row is for a top 2000 application
from player_count_1h

