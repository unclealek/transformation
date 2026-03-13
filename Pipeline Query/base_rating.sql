UPDATE transform.sql_db.staging_bronze
SET
  base_price = least(base_price, 1000),
  user_rating = least(greatest(user_rating,0), 5);