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

## Pull all required geohashes.
pull-all:
	@echo "Pulling geohash list..."
	docker exec ogr2ogr ogrinfo  -ro PG:"postgresql://postgres:postgres@dbm/db"
#docker exec ogr2ogr ogrinfo  -ro PG:"postgresql://postgres:postgres@dbm/db" -sql "SELECT * FROM roi"

## Clean files built by this Makefile.
clean: $(clean_targets)
	@echo "Cleaning all splits built by this Makefile..."
