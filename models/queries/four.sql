SELECT

    f.customer_id,
    c.first_name,
    c.last_name,
    c.phone,
    count(*) AS total_order_items

FROM {{ ref('fact_order_item_create') }} AS f
LEFT JOIN {{ ref('dim_customer') }} AS c ON f.customer_id = c.customer_id
LEFT JOIN {{ ref('dim_product') }} AS p ON f.product_id = p.product_id

WHERE EXTRACT(HOUR FROM f.time_ordered) < 5
    AND p.product_id LIKE 'BKY%'

GROUP BY 1, 2, 3, 4
ORDER BY total_order_items DESC
LIMIT 1
