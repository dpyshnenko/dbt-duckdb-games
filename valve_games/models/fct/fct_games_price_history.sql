WITH
price_hisory AS (SELECT * FROM {{ ref('stg_price_history') }})

SELECT
    *
FROM
    price_hisory
