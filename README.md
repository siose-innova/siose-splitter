# siose-splitter
[![DOI](https://zenodo.org/badge/132134651.svg)](https://zenodo.org/badge/latestdoi/132134651)

This repository contains a set of scripts that help to split parts of a SIOSE database and store these parts in different GIS dataformats (SHP, GPKG) for its distribution. Splits are made using Geohashes so the outputs can be indexed and used in a download service.

All this workflow can be deployed using the Makefile. Execute `make` in the working directory to:

- Launch docker/docker-compose services.
- Load ROIs to a siose database.
- Build splits.
- Push splits to the fileserver.

## Prerrequisites

- GNU Make
- Docker
- Docker-compose
- SIOSE docker images


## Working with this tool

From the working directory, execute the main command (`make`) to see the help of the Makefile. This Makefile creates a customized `docker-compose.yml` file so you can add a lightweight client to explore the database

```bash
make pgclient=psql start-services
```
PGAdmin4 or QGIS are also available.
```bash
make pgclient=pgadmin start-services
```

1. Download the list of target geohashes

```bash
make setup
```

2. Create a *.gh file foreach target geohash.
3. Build `splits` of the SIOSE in a specific format.
4. Obtener todos los `splits` en todos los formatos.
5. ...


## TODOs

- Implement a logging strategy [See this thread](https://stackoverflow.com/questions/8483149/gnu-make-timing-a-build-is-it-possible-to-have-a-target-whose-recipe-executes)
- Paralelization: Test make -j + compose scale. make -j works pretty good, but compose --scale seems to make no difference.
