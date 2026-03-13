DELETE FROM transform.sql_db.staging_bronze
WHERE row_id IN (
  SELECT row_id FROM (
    SELECT row_id, row_number() OVER (
      PARTITION BY user_id, first_name, last_name, email_addr, region_name, sale_date, base_price, jan_sales, feb_sales, user_rating
      ORDER BY row_id 
    ) AS dup_cnt
    FROM transform.sql_db.sales_silver
  ) t
  WHERE dup_cnt > 1
)