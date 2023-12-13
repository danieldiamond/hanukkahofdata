SELECT

    f.customer_id,
    c.first_name,
    c.last_name,
    c.phone,
    count(*) AS total_order_items

FROM {{ ref('fact_order_item_create') }} AS f
LEFT JOIN {{ ref('dim_customer') }} AS c ON f.customer_id = c.customer_id
LEFT JOIN {{ ref('dim_product') }} AS p ON f.product_id = p.product_id

WHERE c.citystatezip LIKE 'Staten Island%'
    AND p.description LIKE '%Senior Cat%'

GROUP BY 1, 2, 3, 4
ORDER BY total_order_items DESC
LIMIT 1
