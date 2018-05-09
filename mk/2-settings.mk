
# Prefix for splits
dbs := siose

# List SIOSE years to be processed
#versions := 2005 2011 2014
db_versions := 2005
#split_prefix := $(db)-$(version) 
extensions := shp


# PG connection string
# It is assumed that this database has to be running
POSTGRES_HOST := dbm
POSTGRES_PORT := 5432 # Needed?
POSTGRES_DB := db
POSTGRES_USER := postgres
POSTGRES_PASSWORD := postgres

CSTRING := PG:\"postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@$(POSTGRES_HOST)/$(POSTGRES_DB)\"


# Fileserver where splits are published
fileserver := sigua.ua.es...
