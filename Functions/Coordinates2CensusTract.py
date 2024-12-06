# This simple function gives the census tract and affiliated information (i.e. entire row) for a set of given coordinates.
#  Needless to say, this code can be used (without change) for more granular (e.g. Block Groups) or more broad (e.g. counties) areas.
# Example use:
# ucsd = Coordinates2CensusTract(latitude=32.881178,longitude=-117.233350)
def Coordinates2CensusTract(
        longitude,
        latitude,
        census_tracts = '/Users/melek/Documents/Data/Census/tl_2024_06_tract/tl_2024_06_tract.shp'
        ):
    
    import geopandas as gpd
    from shapely.geometry import Point

    point = Point(longitude, latitude)
    CTs = gpd.read_file(census_tracts)
    census_tract = CTs[CTs.contains(point)]

    return census_tract