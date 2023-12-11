SELECT
    name, phone
FROM dim_customer
WHERE phone_stripped = name_to_number;
