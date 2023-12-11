SELECT
    {{ dbt_utils.generate_surrogate_key([
        'orderid',
        'sku'
    ]) }} AS order_item_id,
    orderid AS order_id,
    sku AS product_id,
    qty,
    unit_price
FROM {{ source('noahs', 'orders_items') }}