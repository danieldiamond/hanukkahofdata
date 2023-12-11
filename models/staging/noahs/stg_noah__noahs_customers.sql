SELECT
    customerid as customer_id,
    name,
    split_part(name, ' ', 1) AS first_name,
    split_part(name, ' ', 2) AS last_name,
    address,
    citystatezip,
    birthdate,
    timezone,
    lat,
    long,
    phone
FROM {{ source('noahs', 'customers') }}