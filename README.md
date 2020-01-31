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

From the working directory, execute the main command (`make`) to see the help of the Makefile. 

This Makefile creates a customized `docker-compose.yml` file so you can add a client to explore the database. The options are:

- psql

```bash
make pgclient=psql start-services
```

- PGAdmin4 available at localhost:5050

```bash
make pgclient=pgadmin start-services
```

- QGIS is also available, but you may also need to run command `xhost +` on the host (before running this command).

```
make pgclient=qgis start-services
```

### Workflow

*Check the output files in the outputs folder.*

Download the list of target geohashes. This creates some geohash based grids that are needed to iterate using Make.

```bash
make setup
```

Build one `split` from SIOSE in a specific format.

```bash
make siose-2005-ezp6.gpkg
```

Or obtain all the `splits` in different formats.

```bash
make build-gpkgs
```

Once this is done, we can edit the SQL expression that selects the attributes and customize the exported data.


## TODOs

- Implement a logging strategy [See this thread](https://stackoverflow.com/questions/8483149/gnu-make-timing-a-build-is-it-possible-to-have-a-target-whose-recipe-executes)
- Store outputs in the project's NAS.
- Paralelization: Test make -j + compose scale. make -j works pretty good, but compose --scale seems to make no difference.
