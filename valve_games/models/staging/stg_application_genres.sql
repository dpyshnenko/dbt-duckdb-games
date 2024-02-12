{{
    config(
        materialized='view'
    )
}}

with

application_genres as (
    select * from {{ source('staging', 'application_genres')}}
)

select
    {{ dbt_utils.generate_surrogate_key(['appId', 'genre']) }} as genre_id,
    appId as application_id,
    genre as game_genre
from application_genres
where genre is not null
