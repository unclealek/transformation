--stage 1
UPDATE transform.sql_db.staging_bronze
SET email_addr= 
  regexp_replace(
    regexp_replace(
      regexp_replace(
        regexp_replace(email_addr, '#', ''),
        '%', ''),
      '#example', '@example'),
    '_com', '.com'
  );

--stage 2
UPDATE transform.sql_db.staging_bronze
SET email_addr = regexp_replace(email_addr, 'example.com$', '@example.com')
WHERE email_addr NOT LIKE '%@%';

--stage 3
UPDATE transform.sql_db.staging_bronze
SET email_addr =
  concat(replace(email_addr, 'example.com', ''), '@example.com')
  WHERE email_addr LIKE '%example.com' 
  AND email_addr NOT LIKE '%@%';

--stage 4
UPDATE transform.sql_db.staging_bronze
SET email_addr =
  concat(replace(email_addr, '@example', ''), '@example.com')
  WHERE email_addr LIKE '%@example' ;

--stage 5
UPDATE transform.sql_db.staging_bronze
SET email_addr =
  concat(replace(email_addr, '@example', ''), '@example.com')
  WHERE email_addr LIKE '%@example' ;

--stage 6
UPDATE transform.sql_db.staging_bronze
SET email_addr =
  concat(replace(email_addr, '.com', ''), '@example.com') 
WHERE email_addr NOT LIKE '%.com%';

--stage 7
UPDATE transform.sql_db.staging_bronze
SET email_addr =
  concat(replace(email_addr, '@.com', ''), '@example.com') 
WHERE email_addr NOT LIKE '%@example%';
