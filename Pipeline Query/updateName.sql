UPDATE transform.sql_db.staging_bronze
SET 
  first_name = COALESCE(first_name, SPLIT_PART(email_addr, last_name, 1)),
  last_name = COALESCE(last_name, nullif(SPLIT_PART(SPLIT_PART(email_addr, '@', 1), first_name, 2), '')),
  email_addr = CONCAT(
      COALESCE(first_name, SPLIT_PART(email_addr, last_name, 1)),
      COALESCE(last_name, nullif(SPLIT_PART(SPLIT_PART(email_addr, '@', 1), first_name, 2), '')),
      '@example.com'
  )
WHERE first_name IS NULL OR last_name IS NULL OR email_addr IS NULL