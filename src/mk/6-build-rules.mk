################
# DEFINE RULES #
################

# Iterate over a list of geohashes (db, versions, extension) and build files with the pattern "ext/siose-xxxx-geohash.ext".
define get-build-rule

## Build one split (e.g. make build-siose-2005-spO4.shp).
build-$1-$2-$3.$4: $(out_dir)/$4/$1-$2-$3.$4.zip

$(out_dir)/$4/$1-$2-$3.$4.zip: $(out_dir)/$4/$1-$2-$3.$4


# Group all targets by extension
$4_targets += $(out_dir)/$4/$1-$2-$3.$4.zip

# TODO: Here we could group targets by database or version

endef


# Get build rules
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

## Build ESRI Shapefile 'splits'
build-shps: $(shp_dir)/siose-2005-sp0r1.shp.zip

# TODO: uncomment this for production
# build-shps: $(shp_targets)

#################
# PATTERN RULES #
#################
# Zip and remove shp files
%.shp.zip: %.shp %.dbf %.shx
	@$(BASH) -c 'cd /$(@D) && zip -q $(@F) $(^F) && rm $(^F)'
	

$(shp_dir)/%.shp $(shp_dir)/%.dbf $(shp_dir)/%.shx: $(gh_dir)/%.gh | checkdirs
	@echo -n "Splitting $(@F) ..."
	@$(GET_SHP) /$@ $(FROM_SIOSE_2005) $(AS) "SELECT * FROM gh WHERE id = '$(*F)';"
	@echo "Done."


