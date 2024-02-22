{{
    config(
        materialized = "table"
    )
}}

{{ dbt_date.get_date_dimension('2017-12-14', '2020-08-12') }}
