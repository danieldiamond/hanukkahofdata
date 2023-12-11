SELECT

    c.customer_id,
    c.first_name,
    c.last_name,
    c.phone,
    count(*) AS count

FROM {{ ref('fact_order_item_create') }} AS f
LEFT JOIN {{ ref('dim_order') }} AS o ON f.order_id = o.order_id
LEFT JOIN {{ ref('dim_customer') }} AS c ON f.customer_id = c.customer_id
LEFT JOIN {{ ref('dim_product') }} AS p ON f.product_id = p.product_id

WHERE EXTRACT(HOUR FROM f.time_ordered) < 5
    AND p.product_id LIKE 'BKY%'

GROUP BY 1, 2, 3, 4 ORDER BY COUNT DESC LIMIT 1
