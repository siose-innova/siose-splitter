
# TODO: Read these from docker-compose.yml. Maybe this could go after docker.mk

# Prefix for splits
dbs := siose

# List SIOSE years to be processed
#db_versions := 2005 2011 2014
db_versions := 2005

#extensions := shp gpkg geojson
extensions := shp

precisions := 2 3 4 5 6

# TODO: one connection for each db?
# PG connection string. It is assumed that this database has to be running.
POSTGRES_HOST := dbm
POSTGRES_PORT := 5432 # Needed?
POSTGRES_DB := db
POSTGRES_USER := postgres
POSTGRES_PASSWORD := postgres

CSTRING := PG:postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@$(POSTGRES_HOST)/$(POSTGRES_DB)


# Fileserver where splits are published
fileserver := sigua.ua.es...
