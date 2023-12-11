SELECT
    c.customer_id, c.first_name, c.last_name, c.phone, count(*) c
FROM {{ ref('fact_order_item_create') }} f
LEFT JOIN {{ ref('dim_customer') }} c ON f.customer_id = c.customer_id
LEFT JOIN {{ ref('dim_product') }} p ON f.product_id = p.product_id
WHERE c.citystatezip LIKE 'Staten Island%'
    AND p.description LIKE '%Senior Cat%'
GROUP BY 1,2,3,4 ORDER BY c DESC LIMIT 1