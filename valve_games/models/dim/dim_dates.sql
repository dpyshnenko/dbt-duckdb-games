{{
    config(
        materialized = "table"
    )
}}

WITH stg_dates AS (
    SELECT * FROM {{ ref('stg_dates') }}
)

SELECT
    date_day AS date_day,
    day_of_week_iso AS day_of_week_iso,
    week_of_year AS week_of_year,
    iso_week_start_date AS iso_week_start_date,
    month_of_year AS month_of_year,
    year_number AS year_number,
    quarter_of_year AS quarter_of_year

FROM
    stg_dates
