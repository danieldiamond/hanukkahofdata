SELECT
    f.customer_id, c.first_name, c.last_name, c.phone, count(*) AS count
FROM {{ ref('fact_order_item_create') }} f
LEFT JOIN {{ ref('dim_order') }} o ON f.order_id = o.order_id
LEFT JOIN {{ ref('dim_customer') }} c ON f.customer_id = c.customer_id
LEFT JOIN {{ ref('dim_product') }} p ON f.product_id = p.product_id

WHERE EXTRACT(HOUR FROM f.time_ordered) < 5
    AND (p.description LIKE '%Twist%'
    OR p.description LIKE '%Babka%'
    OR p.description LIKE '%Blintz%'
    OR p.description LIKE '%Cookie%'
    OR p.description LIKE '%Hamentash%'
    OR p.description LIKE '%Knish%'
    OR p.description LIKE '%Latke%'
    OR p.description LIKE '%Puff%'
    OR p.description LIKE '%Rugelach%'
    OR p.description LIKE '%Sufganiah%'
    OR p.description LIKE '%Twist%'
    )

GROUP BY 1, 2, 3, 4 ORDER BY COUNT DESC LIMIT 1
