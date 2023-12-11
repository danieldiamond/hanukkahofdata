SELECT
    orderid as order_id,
    customerid as customer_id,
    ordered AS time_ordered,
    shipped AS time_shipped,
    items,
    total
FROM {{ source('noahs', 'orders') }}