
include $(sort $(wildcard contrib/*.mk))
include $(sort $(wildcard src/mk/*.mk))

## Build and push all splits to the fileserver.
all: $(build_targets)

#TODO: Better test if services are up and ready

## Start all services (posgtres, ogr, pgadmin, etc)
start-services: running-services.yml
running-services.yml: $(compose)
	@echo "Building and starting all services ... "
	@docker-compose -f $< up -d
	@$(file > $@,"dbm,pgadmin,etc")
	@rm stopped-services.yml
	@echo "Done."

## Stop all services and remove containers.
stop-services: stopped-services.yml
stopped-services.yml: $(compose)
	@echo "Stopping and removing all services ... "
	@docker-compose -f $< down -v
	@$(file > $@,"All services are down.")
	@rm running-services.yml
	@echo "Done."



