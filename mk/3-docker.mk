
# SHELL needed?
SHELL = /bin/sh

# IMAGES
SIOSE_2005_IMAGE    = sioseinnova/siose-2005-geohashed
GDAL_IMAGE          = sioseinnova/gdal
BASH_IMAGE          = sioseinnova/alpine-bash

PGADMIN_IMAGE       = fenglc/pgadmin4:latest

# DOCKER
DOCKER              = docker
DOCKER_EXEC         = $(DOCKER) exec
DOCKER_WORKDIR      = /outputs

#DOCKER_RUN          = $(DOCKER) run
#DOCKER_RUN_OPTIONS  = --rm
#DOCKER_RUN_WORKDIR  = --workdir /outputs
#DOCKER_VOLUME       = --volume $(PWD)/outputs:/outputs

# CONTAINERS
SIOSE_2005_CONTAINER = dbm
GDAL_CONTAINER      = gdal
BASH_CONTAINER      = bash
PGADMIN_CONTAINER   = pgadmin


# OGR2OGR
OGR2OGR             = $(DOCKER_EXEC) -it $(GDAL_CONTAINER) ogr2ogr
OGR2OGR_OPTIONS     =
SHP_OPTIONS         =
GPKG_OPTIONS        =


# Readability?
GET_CSV             = $(OGR2OGR) -f "CSV"
GET_SHP             = $(OGR2OGR) -f "ESRI Shapefile"

FROM_SIOSE_2005     = $(CSTRING)

# TODO: is it clear?
AS                  = -sql

# ALPINE-BASH
RM = $(DOCKER_EXEC) -it $(BASH_CONTAINER) rm -rf
MKDIR = $(DOCKER_EXEC) -it $(BASH_CONTAINER) mkdir -p
TOUCH = $(DOCKER_EXEC) -it $(BASH_CONTAINER) touch
BASH = $(DOCKER_EXEC) -it $(BASH_CONTAINER) /bin/bash
