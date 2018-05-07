include mk/*.mk

## Build and push all splits to the fileserver.
all: pull-all build-all push-all

## Build all splits locally.
build-all: $(build_targets)
	@echo "Building all 'splits'..."

## Push all splits to the fileserver.
push-all: $(push_targets)
	@echo "Pushing all splits..."

## Pull all required geohashes.
pull-all: $(pull_targets)
	@echo "It's done."
