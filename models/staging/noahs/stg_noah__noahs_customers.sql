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
    phone,
    replace(phone,'-','') AS phone_stripped,
    name_to_number(last_name) AS name_to_number
FROM {{ source('noahs', 'customers') }}