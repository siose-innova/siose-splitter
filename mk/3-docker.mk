# TODO: Read these from docker-compose.yml
# TODO: or better create a docker-compose.yml file frome these :)

# SHELL needed?
SHELL = /bin/sh

# IMAGES
SIOSE_2005_IMAGE    = sioseinnova/siose-2005-geohashed
OGR2OGR_IMAGE       = sioseinnova/postgis-ext

# DOCKER
DOCKER              = docker
DOCKER_EXEC         = $(DOCKER) exec
#DOCKER_RUN          = $(DOCKER) run
#DOCKER_RUN_OPTIONS  = --rm
#DOCKER_RUN_WORKDIR  = --workdir /outputs
#DOCKER_VOLUME       = --volume $(PWD)/outputs:/outputs

# CONTAINERS
OGR2OGR_CONTAINER   = ogr2ogr

# OGR2OGR
OGR2OGR             = $(DOCKER_EXEC) -it $(OGR2OGR_CONTAINER) ogr2ogr
OGR2OGR_OPTIONS     =
SHP_OPTIONS         =
GPKG_OPTIONS        =


# Readability?
GET_CSV             = $(OGR2OGR) -f "CSV"
GET_SHP             = $(OGR2OGR) -f "ESRI Shapefile"

FROM_SIOSE_2005     = $(CSTRING)

# TODO: is it clear?
AS                  = -sql
