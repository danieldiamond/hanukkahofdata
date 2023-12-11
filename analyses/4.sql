
WITH early_pastry_shoppers AS (
    SELECT
        f.order_id, c.customer_id, c.first_name, c.last_name, c.phone, d.description
    FROM fact_order_item_create f
    LEFT JOIN dim_order o ON f.order_id = o.order_id
    LEFT JOIN dim_customer c ON f.customer_id = c.customer_id
    LEFT JOIN dim_product d ON f.product_id = d.product_id

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
    )

-- SELECT * FROM early_pastry_shoppers
-- Replace the SELECT above with the one below to see the order results
SELECT DISTINCT customer_id, first_name, last_name, phone FROM early_pastry_shoppers
WHERE customer_id IN (
    SELECT customer_id FROM (
        SELECT customer_id, COUNT(*) AS count FROM early_pastry_shoppers GROUP BY customer_id ORDER BY count DESC LIMIT 1
    )
);
