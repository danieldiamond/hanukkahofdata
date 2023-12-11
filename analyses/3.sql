SELECT
    customer_id, first_name, last_name, birthdate, phone
FROM dim_customer
WHERE citystatezip = (SELECT citystatezip FROM dim_customer WHERE customer_id = 1475)
    AND year(birthdate) IN (1927, 1939, 1951, 1963, 1975, 1987, 1999, 2011, 2023)
    AND (
        (MONTH(birthdate) = 6 AND day(birthdate) BETWEEN 22 AND 30)
        OR (MONTH(birthdate) = 7 AND day(birthdate) BETWEEN 1 AND 22)
    );
