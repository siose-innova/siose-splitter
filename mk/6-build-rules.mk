################
# DEFINE RULES #
################

# TODO: Iterate over a list of geohashes (versions, extension) and build files with the pattern "siose-xxxx-geohash.ext".
define get-build-rule

## Build one split. Replace all variables as needed (e.g. make build-siose-2005-spO4.shp).
build-$1-$2-$3.$4: $(out_dir)/$4/$1-$2-$3.$4

# Group all targets by extension
$4_targets += build-$1-$2-$3.$4

endef


# TODO: Cuadruple loop | siose-2005-sp0r.shp
$(foreach db,$(dbs),\
	$(foreach version,$(db_versions),\
		$(foreach geohash,$(geohashes),\
			$(foreach ext,$(extensions),\
				$(eval $(call get-build-rule,$(db),$(version),$(geohash),$(ext)))\
			)\
		)\
	)\
)

###########
# TARGETS #
###########
build_targets := $(shp_targets)


#########
# RULES #
#########

## Build all 'splits'
build-all: build-shps

## Build ESRI Shapefile 'splits'
build-shps: $(shp_targets)


#################
# PATTERN RULES #
#################
$(shp_dir)/%.shp: $(gh_dir)/%.gh | checkdirs
	@echo -n "Splitting $(@F) ..."
	@$(DOCKER_EXEC) -it $(OGR2OGR_CONTAINER) \
	$(OGR2OGR) \
	-f "ESRI Shapefile" /$@ \
	PG:"postgresql://postgres:postgres@dbm/db" \
	-sql "SELECT * FROM gh WHERE id = '$(*F)';"
	@echo "Done."


