SELECT

    f.customer_id,
    c.first_name,
    c.last_name,
    c.phone,
    p.product_id,
    p.description,
    f.time_ordered

FROM {{ ref('fact_order_item_create') }} AS f
LEFT JOIN {{ ref('dim_order') }} AS o ON f.order_id = o.order_id
LEFT JOIN {{ ref('dim_customer') }} AS c ON f.customer_id = c.customer_id
LEFT JOIN {{ ref('dim_product') }} AS p ON f.product_id = p.product_id
