SELECT

    oi.order_item_id AS order_item_create_id,
    oi.order_id,
    oi.product_id,
    oi.qty,
    oi.unit_price,
    o.customer_id,
    o.time_ordered

FROM {{ ref('stg_noah__noahs_orders_items') }} AS oi
LEFT JOIN {{ ref('stg_noah__noahs_orders') }} AS o
    ON oi.order_id = o.order_id