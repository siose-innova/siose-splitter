


# TODO: Iterate over a list of geohashes (versions, extension) and build files with the pattern "siose-xxxx-geohash.ext".

define get-build-rule
## Build one split. Replace $1 by ... you want to build (e.g. make build-...).
build-$1: 

build_targets+= build-$1

endef

# TODO: Triple loop version -> geohash -> extension
$(foreach x,$(geohashes),\
	$(eval $(call get-build-rule,$(x)))\
)




# Get one shp split per geohash
$(out_dir)/%.shp : $(out_dir)/%-split.shp | checkdirs
	@echo -n "Retrieving geohash... "
	@$(DOCKER_RUN) $(DOCKER_RUN_OPTIONS) \
	$(DOCKER_RUN_WORKDIR) \
	$(OGR2OGR) \
	$(DOCKER_VOLUME) \
	$(OGR2OGR_IMAGE) \
	--output=$@ \
	$(filter-out $<,$^) \
	--template=$<
	@echo "Done."
