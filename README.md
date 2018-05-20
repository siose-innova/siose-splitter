# siose-splitter

Prerrequisites:

- Docker
- Docker-compose
- Make
- Images from the siose-docker-library

This makefile helps to:

- Launch docker/docker-compose services.
- Load ROIs to a siose database.
- Build splits.
- Push splits to the fileserver.

## TODOs

- Implement a logging strategy [See this thread](https://stackoverflow.com/questions/8483149/gnu-make-timing-a-build-is-it-possible-to-have-a-target-whose-recipe-executes)
- Test make -j + compose scale. make -j works pretty good, but compose --scale seems to make no difference.
