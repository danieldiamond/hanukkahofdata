WITH old_customers AS (
    SELECT
        customer_id,
        MAX(YEAR(time_ordered)) AS max_time_ordered
    FROM {{ ref('fact_order_item_create') }}
    GROUP BY 1
    HAVING max_time_ordered = 2017
)

SELECT DISTINCT

    f.customer_id,
    c.first_name,
    c.last_name,
    c.phone,
    c.citystatezip

FROM {{ ref('fact_order_item_create') }} AS f
JOIN {{ ref('dim_order') }} AS o ON f.order_id = o.order_id
JOIN {{ ref('dim_customer') }} AS c ON f.customer_id = c.customer_id
JOIN {{ ref('dim_product') }} AS p ON f.product_id = p.product_id

WHERE YEAR(o.time_ordered) = 2017
    AND c.first_name like 'D%'
    AND c.last_name like 'S%'
    AND (LOWER(p.description) like '%coffee%'
        OR LOWER(p.description) like '%bagel%'
    )
    AND f.customer_id IN (SELECT customer_id FROM old_customers)
