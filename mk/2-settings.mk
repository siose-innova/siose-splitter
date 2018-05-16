
# TODO: Read these from docker-compose.yml or better make/write a compose from these and docker.mk... :)

# Prefix for splits
dbs := siose

# List SIOSE years to be processed
#db_versions := 2005 2011 2014
db_versions := 2005

#precisions := 2 3 4 5 6
precisions := 3

#extensions := shp gpkg geojson
extensions := shp


# Fileserver where splits are published
#fileserver := sigua.ua.es...
