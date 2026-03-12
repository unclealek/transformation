import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta
from faker import Faker

fake = Faker()

def generate_messy_data(rows=100):
    regions = ['North', 'South', 'East', 'West', 'Central', 'Unknown']
    records = []

    batch_id = f"batch_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
    ingestion_timestamp = datetime.now()

    for i in range(1, rows + 1):
        first_name = fake.first_name()
        last_name = fake.last_name()
        email_addr = f"{first_name.lower()}{last_name.lower()}@example.com"

        record = {
            'user_id': i,
            'first_name': first_name,
            'last_name': last_name,
            'email_addr': email_addr,
            'region_name': random.choice(regions),
            'sale_date': (datetime(2023, 1, 1) + timedelta(days=random.randint(0, 364))).strftime('%Y-%m-%d'),
            'base_price': round(random.uniform(10.0, 500.0), 2),
            'jan_sales': random.randint(0, 1000),
            'feb_sales': random.randint(0, 1000),
            'user_rating': random.randint(1, 5),
            'batch_id': batch_id,
            'ingestion_timestamp': ingestion_timestamp
        }

        # Inject random messiness
        if random.random() < 0.10:
            record['user_id'] = np.nan

        if random.random() < 0.10:
            record['first_name'] = None

        if random.random() < 0.10:
            record['last_name'] = None

        if random.random() < 0.15:
            record['region_name'] = record['region_name'].lower()

        if random.random() < 0.10:
            record['sale_date'] = None

        if random.random() < 0.05:
            record['base_price'] = 99999.99

        if random.random() < 0.10:
            record['user_rating'] = 99

        email_issue = random.random()

        if email_issue < 0.08:
            record['email_addr'] = None
        elif email_issue < 0.16:
            record['email_addr'] = f"{first_name.lower()}#{last_name.lower()}@example.com"
        elif email_issue < 0.24:
            record['email_addr'] = f"{first_name.lower()}%{last_name.lower()}example.com"
        elif email_issue < 0.32:
            record['email_addr'] = f"{first_name.lower()}{last_name.lower()}#example_com"
        elif email_issue < 0.40:
            record['email_addr'] = f"{first_name.lower()}.{last_name.lower()}@example"
        elif email_issue < 0.48:
            record['email_addr'] = f"{first_name.lower()}{last_name.lower()}@.com"

        records.append(record)

    df = pd.DataFrame(records)

    # Add duplicate rows
    for _ in range(10):
        duplicate_row = df.iloc[[random.randint(0, len(df) - 1)]]
        df = pd.concat([df, duplicate_row], ignore_index=True)

    return df

messy_df = generate_messy_data(20)
print(messy_df.head(20))