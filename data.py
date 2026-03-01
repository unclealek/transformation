import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta

def generate_messy_data(rows=100):
    regions = ['North', 'South', 'East', 'West', 'Central', 'Unknown']
    
    data = {
        'user_id': [i if random.random() > 0.1 else np.nan for i in range(1, rows + 1)],
        'email_addr': [f"user_{i}@example.com" if random.random() > 0.2 else f"user_{i}#example_com" for i in range(rows)],
        'region_name': [random.choice(regions) if random.random() > 0.15 else random.choice(regions).lower() for _ in range(rows)],
        'sale_date': [(datetime(2023, 1, 1) + timedelta(days=random.randint(0, 365))).strftime('%Y-%m-%d') for _ in range(rows)],
        'base_price': [round(random.uniform(10.0, 500.0), 2) for _ in range(rows)],
        'jan_sales': [random.randint(0, 1000) for _ in range(rows)],
        'feb_sales': [random.randint(0, 1000) for _ in range(rows)],
        'user_rating': [random.randint(1, 5) if random.random() > 0.1 else 99 for _ in range(rows)]
    }

    '''
    user_id : generates a unique identifier for each user, but with a 10% chance of being null (NaN) 
    email_addr : generates a valid email address for each row, but with a 20% chance of generating an invalid email address (e.g., missing @ or .com)   
    region_name : uses random of random function starting with 0.15 to give the first user a region and does the same for the next row 
                  but if the random function generate a string it gives that row a lower case region name
    sale_date : generates a random date between 2023-01-01 and 2023-12-31 for each row
    base_price : generates a random float between 10.0 and 500.0 for each row
    jan_sales : generates a random integer between 0 and 1000 for each row
    feb_sales : generates a random integer between 0 and 1000 for each row
    user_rating : generates a random integer between 1 and 5 for each row, but with a 10% chance of being an outlier value of 99
    '''
    df = pd.DataFrame(data)

    # Injecting "Messiness" manually
    for i in range(10):
        # Add some nulls to random columns
        df.loc[random.randint(0, rows-1), 'sale_date'] = None
        # Add some extreme outliers to prices
        df.loc[random.randint(0, rows-1), 'base_price'] = 99999.99
        # Add duplicate rows
        df = pd.concat([df, df.iloc[[random.randint(0, rows-1)]]], ignore_index=True)

    return df

# Generate and view
messy_df = generate_messy_data()
print(messy_df.head(15))