INSERT INTO transform.sql_db.sales_reject
SELECT * FROM transform.sql_db.staging_bronze
WHERE
    first_name IS NULL
    OR last_name IS NULL
    OR email_addr IS NULL
    OR user_rating < 0
    OR user_rating > 5
    OR base_price > 1000
    OR region_name NOT IN ('north', 'south', 'east', 'west', 'unknown', 'central')
    OR email_addr NOT LIKE '%@example.com%'