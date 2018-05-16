
include $(sort $(wildcard contrib/*.mk))
include $(sort $(wildcard src/mk/*.mk))

## Build and push all splits to the fileserver.
all: pull-all build-all

## Start all services (posgtres, ogr, pgadmin, etc)
start-services: docker-compose.yml
	docker-compose -f $< up -d

## Stop all services and remove containers.
stop-services: docker-compose.yml
	docker-compose -f $< down -v

## Pull all required geohashes.
pull-all: $(pull_targets)
	@echo "Pulled all geohashes from DB."

## Build all splits locally.
build-all: $(build_targets)
	@echo "Built all 'splits' from geohashes."

# Build all splits locally.
#rebuild-all: clean $(build_targets)
#	@echo "Built all 'splits' from geohashes, again."

# Push all splits to the fileserver.
#push-all: $(push_targets)
#	@echo "Pushing all 'splits' to the fileserver."


