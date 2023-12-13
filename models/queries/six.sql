SELECT

    c.customer_id,
    c.first_name,
    c.last_name,
    c.phone,
    SUM(f.qty * (f.unit_price - p.wholesale_cost)) AS profit

FROM {{ ref('fact_order_item_create') }} AS f
LEFT JOIN {{ ref('dim_customer') }} AS c ON f.customer_id = c.customer_id
LEFT JOIN {{ ref('dim_product') }} AS p ON f.product_id = p.product_id

GROUP BY 1, 2, 3, 4
HAVING profit < 0
ORDER BY profit
LIMIT 1
