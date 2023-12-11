SELECT
    f.*
FROM fact_order_item_create f
LEFT JOIN dim_order o ON f.order_id = o.order_id
LEFT JOIN dim_customer c ON f.customer_id = c.customer_id
LEFT JOIN dim_product d ON f.product_id = d.product_id
