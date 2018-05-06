# SHELL needed?
SHELL = /bin/sh

# TODO: Read these from docker-compose.yml

# IMAGES
SIOSE_2005_IMAGE    = sioseinnova/siose-2005-geohashed
ALPINE_BASH_IMAGE   = benizar/alpine-bash

OGR2OGR_IMAGE       = sioseinnova/postgis-ext

# DOCKER
DOCKER              = docker
DOCKER_EXEC         = $(DOCKER) exec
DOCKER_RUN          = $(DOCKER) run
DOCKER_RUN_OPTIONS  = --rm
DOCKER_RUN_WORKDIR  = --workdir /source
DOCKER_VOLUME       = --volume $(PWD):/source

# CONTAINERS
OGR2OGR_CONTAINER   = ogr2ogr

# OGR2OGR
OGRINFO             = --entrypoint ogrinfo
OGR2OGR_OPTIONS     = -ro

OGR2OGR             = --entrypoint ogr2ogr
OGR2OGR_OPTIONS     =
SHP_OPTIONS         =
GPKG_OPTIONS        =

# ALPINE-BASH
RM = --entrypoint rm
