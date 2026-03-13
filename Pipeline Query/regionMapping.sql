CREATE OR REPLACE VIEW transform.sql_db.sales_silver_north AS
SELECT * FROM transform.sql_db.sales_silver WHERE region_name = 'north';

CREATE OR REPLACE VIEW transform.sql_db.sales_silver_south AS
SELECT * FROM transform.sql_db.sales_silver WHERE region_name = 'south';

CREATE OR REPLACE VIEW transform.sql_db.sales_silver_east AS
SELECT * FROM transform.sql_db.sales_silver WHERE region_name = 'east';

CREATE OR REPLACE VIEW transform.sql_db.sales_silver_west AS
SELECT * FROM transform.sql_db.sales_silver WHERE region_name = 'west';

CREATE OR REPLACE VIEW transform.sql_db.sales_silver_unknown AS
SELECT * FROM transform.sql_db.sales_silver WHERE region_name = 'unknown';

CREATE OR REPLACE VIEW transform.sql_db.sales_silver_central AS
SELECT * FROM transform.sql_db.sales_silver WHERE region_name = 'central';