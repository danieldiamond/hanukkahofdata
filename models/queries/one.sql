SELECT

    name,
    phone

FROM {{ ref('dim_customer') }}

WHERE REPLACE(phone, '-', '') = name_to_number(last_name)
