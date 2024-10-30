import pandas as pd
import shapefile
import os


def shapefile_to_dataframe(file_name):
    # Load the shapefile
    sf = shapefile.Reader(file_name)

    # Get the fields and records
    fields = [field[0] for field in sf.fields[1:]]  # Exclude the DeletionFlag field
    records = sf.records()

    # Create a list to store all the records
    all_records = []

    # Iterate through the records and append them to the list
    for record in records:
        all_records.append(dict(zip(fields, record)))

    # Create a DataFrame from the list of records
    df = pd.DataFrame(all_records)

    return df