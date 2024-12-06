def get_bulk_data(base_url):
    import requests
    import pandas as pd
    from datetime import datetime


    # base_url = "https://services2.arcgis.com/mJaJSax0KPHoCNB6/ArcGIS/rest/services/DRPComplianceRelProd/FeatureServer/23/query"

    params = {
        "where": "1=1",  # Select all records
        "outFields": "*",  # Retrieve all fields
        "f": "json"  # Format response as JSON
    }

    response = requests.get(base_url, params=params)

    if response.status_code == 200:
        # Parse JSON response
        data = response.json()
        
        # Extract features (attributes + geometry)
        features = data.get("features", [])
        
        # Process data
        records = []
        for feature in features:
            attributes = feature.get("attributes", {})  # Data fields
            geometry = feature.get("geometry", {})  # Geographic coordinates
            records.append(attributes)
        df = pd.DataFrame(records)
        # df['Last_Update_On_Map'] = pd.to_datetime(df['Last_Update_On_Map'], unit='ms')
        return df
    else:
        print(f"Error: {response.status_code}")
        print("Response Text:", response.text)
i = 2
base_url = f"https://services2.arcgis.com/mJaJSax0KPHoCNB6/ArcGIS/rest/services/DRPComplianceRelProd/FeatureServer/{i}/query"
df = get_bulk_data(base_url=base_url)
print(df)
df.to_csv("test.csv")
