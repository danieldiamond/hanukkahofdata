SELECT
    customer_id,
    name,
    first_name,
    last_name,
    address,
    citystatezip,
    birthdate,
    timezone,
    lat,
    long,
    phone,
    phone_stripped,
    name_to_number
FROM {{ ref('stg_noah__noahs_customers') }}