SELECT
    order_id,
    customer_id,
    time_ordered,
    time_shipped,
    items,
    total
FROM {{ ref('stg_noah__noahs_orders') }}
