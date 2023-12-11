SELECT
    f.*
FROM {{ ref('fact_order_item_create') }} f
LEFT JOIN {{ ref('dim_order') }} o ON f.order_id = o.order_id
LEFT JOIN {{ ref('dim_customer') }} c ON f.customer_id = c.customer_id
LEFT JOIN {{ ref('dim_product') }} d ON f.product_id = d.product_id
