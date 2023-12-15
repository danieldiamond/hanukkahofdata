WITH unique_collectibles AS (
    SELECT
        SPLIT_PART(description, '(', 1) AS description_summary,
        COUNT(DISTINCT description) AS count
    FROM {{ ref('dim_product') }}
    WHERE product_id like 'COL%'
    GROUP BY description_summary
),

collector AS (
    SELECT

        f.customer_id,
        c.first_name,
        c.last_name,
        c.phone,
        SPLIT_PART(p.description, '(', 1) AS description_summary,
        COUNT(DISTINCT description) AS count

    FROM {{ ref('fact_order_item_create') }} AS f
    LEFT JOIN {{ ref('dim_order') }} AS o ON f.order_id = o.order_id
    LEFT JOIN {{ ref('dim_customer') }} AS c ON f.customer_id = c.customer_id
    LEFT JOIN {{ ref('dim_product') }} AS p ON f.product_id = p.product_id

    WHERE p.product_id LIKE 'COL%'
    GROUP BY 1,2,3,4,5 ORDER BY count desc
)

SELECT DISTINCT

    c.customer_id,
    c.first_name,
    c.last_name,
    c.phone

FROM collector AS c
JOIN unique_collectibles AS uc
    ON c.description_summary = uc.description_summary
    AND c.count = uc.count

