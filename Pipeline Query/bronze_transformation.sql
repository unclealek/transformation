-- Insert data with transformations: trim spaces, lowercase column names, rename problematic columns, add row_id
INSERT INTO transform.sql_db.sales_bronze
SELECT
  CAST(user_id AS DOUBLE) AS user_id,
  TRIM(LOWER(first_name)) AS first_name,
  TRIM(LOWER(last_name)) AS last_name,
  TRIM(LOWER(email_addr)) AS email_addr,
  TRIM(LOWER(region_name)) AS region_name,
  CAST(sale_date AS DATE) AS sale_date,
  base_price,
  jan_sales,
  feb_sales,
  user_rating,
  batch_id,
  ingestion_timestamp,
  monotonically_increasing_id() AS row_id
FROM transform.sql_db.sales_raw r
WHERE NOT EXISTS (
    SELECT 1
    FROM transform.sql_db.sales_bronze b
    WHERE b.batch_id = r.batch_id
);