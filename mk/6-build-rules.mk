
# TODO: Iterate over a list of geohashes (versions, extension) and build files with the pattern "siose-xxxx-geohash.ext".

define get-build-rule
# Build one split. Replace $1 by ... you want to build (e.g. make build-...).
build-$1: pull-$1 $(shp_dir)/$1.shp

$(shp_dir)/$1.shp: $(gh_dir)/$1.gh
	@echo -n "Splitting $@ ..."
	@$(DOCKER_EXEC) -it $(OGR2OGR_CONTAINER) \
	$(OGR2OGR) \
	-f "SHP" $(@F) \
	PG:"postgresql://postgres:postgres@dbm/db" \
	-sql "SELECT * FROM gh WHERE id = $(*F)"
	@echo "Done."

build_targets += build-$1

endef

# TODO: Triple loop version -> geohash -> extension
$(foreach x,$(geohashes),\
	$(eval $(call get-build-rule,$(x)))\
)



# Targets
shp_targets = $(patsubst $(gh_dir)/%.gh,$(shp_dir)/%.shp,$(pull_gh_targets))

## Build Shapefiles from a geohashed SIOSE
build-shp-splits: $(shp_targets)
	@echo $(geohashes)
	@echo $(shp_targets)

# Get one shp split per geohash
$(shp_dir)/%.shp: $(gh_dir)/%.gh
	@echo -n "Splitting $@ ..."
	@$(DOCKER_EXEC) -it $(OGR2OGR_CONTAINER) \
	$(OGR2OGR) \
	-f "SHP" $(@F) \
	PG:"postgresql://postgres:postgres@dbm/db" \
	-sql "SELECT * FROM gh WHERE id = $(*F)"
	@echo "Done."

	
