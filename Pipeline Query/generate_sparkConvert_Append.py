
from data import generate_messy_data

df = generate_messy_data()
spark_df = spark.createDataFrame(df)
spark_df.write.format('delta').option('mergeSchema', 'true').mode('append').saveAsTable('transform.sql_db.sales_raw')