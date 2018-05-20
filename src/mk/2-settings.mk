
# Prefix for splits
dbs := siose

# List SIOSE years to be processed
#db_versions := 2005 2011 2014
db_versions := 2005

precisions := 2 3 4 5 6

#extensions := shp gpkg geojson
extensions := shp


# Fileserver where splits are published
#fileserver := sigua.ua.es...


# Not echoing echoes when performing an experiment... or log it.
# TODO: Decide if this is necessary
echo := @echo 
#echo := \# 
