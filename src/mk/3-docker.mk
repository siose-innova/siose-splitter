
#############
# VARIABLES #
#############

# IMAGES
SIOSE_2005_IMAGE    = sioseinnova/siose-2005:splitter
GDAL_IMAGE          = sioseinnova/gdal:2.2.4
BASH_IMAGE          = sioseinnova/alpine-bash:3.7
PGADMIN_IMAGE       = fenglc/pgadmin4:latest
PSQL_IMAGE          = sioseinnova/postgresql-client:10

# SERVICES
SIOSE_2005_CONTAINER  = dbm
GDAL_CONTAINER        = gdal
BASH_CONTAINER        = bash
PGADMIN_CONTAINER     = pgadmin
PSQL_CONTAINER        = psql

# DOCKER
DOCKER              = docker-compose
DOCKER_EXEC         = $(DOCKER) exec -d
DOCKER_WORKDIR      = /outputs

# POSTGRES
# PG connection string. It is assumed that this database has to be running.
# TODO: one connection for each db?
POSTGRES_HOST := $(SIOSE_2005_CONTAINER)
POSTGRES_PORT := 5432 # Needed?
POSTGRES_DB := db
POSTGRES_USER := postgres
POSTGRES_PASSWORD := postgres

CSTRING := PG:postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@$(POSTGRES_HOST)/$(POSTGRES_DB)

# PGADMIN
PGADMIN_USER     := pgadmin4@pgadmin.org
PGADMIN_PASSWORD := admin


############
# COMMANDS #
############

# OGR2OGR
OGR2OGR             = $(DOCKER_EXEC) $(GDAL_CONTAINER) ogr2ogr
OGR2OGR_OPTIONS     =
SHP_OPTIONS         =
GPKG_OPTIONS        =


# TODO: Check this SQL-like syntax for readability. Is it clear?
GET_CSV             = $(OGR2OGR) -f "CSV"
GET_SHP             = $(OGR2OGR) -f "ESRI Shapefile"

FROM_SIOSE_2005     = $(CSTRING)

AS                  = -sql

# BASH
SHELL = /bin/bash
DOCKER_SHELL = $(DOCKER_EXEC) $(BASH_CONTAINER)
BASH  = $(DOCKER_SHELL) $(SHELL)
RM    = $(DOCKER_SHELL) rm -rf
MKDIR = $(DOCKER_SHELL) mkdir -p
TOUCH = $(DOCKER_SHELL) touch


