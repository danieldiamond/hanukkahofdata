SELECT
    f.customer_id, c.first_name, c.last_name, c.phone, count(*) AS count
FROM {{ ref('fact_order_item_create') }} f
LEFT JOIN {{ ref('dim_order') }} o ON f.order_id = o.order_id
LEFT JOIN {{ ref('dim_customer') }} c ON f.customer_id = c.customer_id
LEFT JOIN {{ ref('dim_product') }} d ON f.product_id = d.product_id

WHERE EXTRACT(HOUR FROM f.time_ordered) < 5
    AND (d.description LIKE '%Twist%'
    OR d.description LIKE '%Babka%'
    OR d.description LIKE '%Blintz%'
    OR d.description LIKE '%Cookie%'
    OR d.description LIKE '%Hamentash%'
    OR d.description LIKE '%Knish%'
    OR d.description LIKE '%Latke%'
    OR d.description LIKE '%Puff%'
    OR d.description LIKE '%Rugelach%'
    OR d.description LIKE '%Sufganiah%'
    OR d.description LIKE '%Twist%'
    )

GROUP BY 1, 2, 3, 4 ORDER BY COUNT DESC LIMIT 1
