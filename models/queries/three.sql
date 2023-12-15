SELECT

    customer_id,
    first_name,
    last_name,
    birthdate,
    phone

FROM {{ ref('dim_customer') }}

WHERE citystatezip = (SELECT citystatezip FROM {{ ref('two') }})
    AND year(birthdate) IN (1931, 1943, 1955, 1967, 1979, 1991, 2003, 2015)
    AND (
        (MONTH(birthdate) = 9 AND day(birthdate) BETWEEN 23 AND 30)
        OR (MONTH(birthdate) = 10 AND day(birthdate) BETWEEN 1 AND 22)
    )