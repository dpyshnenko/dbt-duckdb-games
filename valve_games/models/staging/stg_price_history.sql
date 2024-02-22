WITH price_history AS (
    SELECT * FROM {{ source('staging', 'price_history') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['AppId', 'Date']) }} AS price_history_id,
    CAST(AppId AS INT64) AS application_id,
    Date AS price_date,
    InitialPrice AS initial_price,
    FinalPrice AS final_price,
    Discount AS discount
FROM price_history
