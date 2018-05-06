
# List SIOSE years to be processed
version := 2005 2011 2014

# Manually set these lists or query from the database
geohash_2 := xx
geohash_3 := xxx
geohash_4 := xxxx
geohash_5 := xxxxx
geohash_6 := xxxxxx
geohash_7 := xxxxxxx

geohashes := $(geohash_4)


# PG connection string
# It is assumed that this database has to be running
POSTGRES_HOST := dbm
POSTGRES_PORT := 5432 # Needed?
POSTGRES_DB := db
POSTGRES_USER := postgres
POSTGRES_PASSWORD := postgres

CSTRING := postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@$(POSTGRES_HOST)/$(POSTGRES_DB)


# Fileserver where splits are published
fileserver := sigua.ua.es...
