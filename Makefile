
include $(sort $(wildcard contrib/*.mk))
include $(sort $(wildcard src/mk/*.mk))

.PHONY : all
## Build and push all splits to the fileserver.
all: start-services setup $(build_targets) stop-services

#TODO: Better test if services are up and ready

.PHONY : start-services
## Start all services (posgtres, ogr, pgadmin, etc)
start-services: $(compose)
	@echo "Building and starting all services ... "
	@docker-compose -f $< up #-d #--scale gdal=2
	@echo "Done."

.PHONY : setup
## Pull some lists of geohashes from a geohashed docker database.
setup: $(setup_targets) | checkdirs

.PHONY : stop-services
## Stop all services and remove containers.
stop-services: $(compose)
	@echo "Stopping and removing all services ... "
	@docker-compose -f $< down -v
	@echo "Done."



