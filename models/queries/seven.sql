SELECT

    f.customer_id,
    c.first_name,
    c.last_name,
    c.phone,
    p.description,
    sp.description AS sherri_order_description

FROM {{ ref('fact_order_item_create') }} AS f
LEFT JOIN {{ ref('dim_customer') }} AS c ON f.customer_id = c.customer_id
LEFT JOIN {{ ref('dim_product') }} AS p ON f.product_id = p.product_id
JOIN {{ ref('fact_order_item_create') }} AS sf
    ON sf.customer_id = (SELECT customer_id FROM {{ ref('six') }})
    AND LEFT(sf.product_id, 3) = LEFT(f.product_id, 3)
    AND ABS(DATE_DIFF('minute', sf.time_ordered, f.time_ordered)) < 10
LEFT JOIN {{ ref('dim_product') }} AS sp ON sf.product_id = sp.product_id

WHERE SPLIT_PART(sp.description, '(', 1) = SPLIT_PART(p.description, '(', 1)
    AND f.customer_id != (SELECT customer_id FROM {{ ref('six') }})