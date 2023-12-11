SELECT
    c.first_name, c.last_name, c.phone, d.description
FROM fact_order_item_create f
JOIN dim_order o ON f.order_id = o.order_id
JOIN dim_customer c ON f.customer_id = c.customer_id
JOIN dim_product d ON f.product_id = d.product_id

WHERE YEAR(o.time_ordered) = 2017
    AND c.first_name like 'J%'
    AND c.last_name like 'P%'
    AND (LOWER(d.description) like '%coffee%'
        OR LOWER(d.description) like '%bagel%'
    );
