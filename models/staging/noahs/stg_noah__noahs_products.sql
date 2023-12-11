SELECT
    sku AS product_id,
    "desc" AS description,
    wholesale_cost,
    dims_cm
FROM {{ source('noahs', 'products') }}