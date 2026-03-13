INSERT INTO transform.sql_db.sales_silver
SELECT
  CAST(user_id AS LONG) AS user_id,
  CAST(first_name AS STRING) AS first_name,
  CAST(last_name AS STRING) AS last_name,
  CAST(email_addr AS STRING) AS email_addr,
  CAST(region_name AS STRING) AS region_name,
  CAST(sale_date AS DATE) AS sale_date,
  CAST(base_price AS DECIMAL(10,2)) AS base_price,
  CAST(jan_sales AS LONG) AS jan_sales,
  CAST(feb_sales AS LONG) AS feb_sales,
  CAST(user_rating AS LONG) AS user_rating,
  batch_id,
  ingestion_timestamp,
  row_id,
  current_timestamp() AS silver_processed_timestamp
FROM transform.sql_db.cleaned_bronze_view
WHERE
  user_id IS NOT NULL
  AND first_name IS NOT NULL
  AND last_name IS NOT NULL
  AND email_addr IS NOT NULL
  AND region_name IS NOT NULL
  AND sale_date IS NOT NULL
  AND email_addr like '%@example.com%'
  AND user_rating >= 0
AND user_rating <= 5
AND base_price <=1000;