SELECT
    product_id,
    description,
    wholesale_cost,
    dims_cm
FROM {{ ref('stg_noah__noahs_products') }}