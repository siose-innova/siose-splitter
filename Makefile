include mk/*.mk

## Build and push all splits to the fileserver.
all: pull-all build-all push-all

## Build all splits locally.
build-all: $(build_targets)
	@echo "Retrieving list of geohashes (based on ROI)..."
	@echo "Building all 'splits'..."

## Push all splits to the fileserver.
push-all: $(push_targets)
	@echo "Pushing all splits..."

## Pull all required images from the registry.
pull-all: $(pull_targets)
	@echo "Pulling all required images..."
	@echo "Pulling ROIs..."

## Clean files built by this Makefile.
clean: $(clean_targets)
	@echo "Cleaning all splits built by this Makefile..."
