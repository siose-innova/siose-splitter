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
DOCKER_RUN          = $(DOCKER) run
DOCKER_RUN_OPTIONS  = --rm
DOCKER_RUN_WORKDIR  = --workdir /outputs
DOCKER_VOLUME       = --volume $(PWD)/outputs:/outputs

# CONTAINERS
OGR2OGR_CONTAINER   = ogr2ogr

# OGR2OGR
OGRINFO             = --entrypoint ogrinfo
OGR2OGR_OPTIONS     = -ro

OGR2OGR             = ogr2ogr
OGR2OGR_OPTIONS     =
SHP_OPTIONS         =
GPKG_OPTIONS        =

