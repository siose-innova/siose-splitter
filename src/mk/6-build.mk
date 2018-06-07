################
# DEFINE RULES #
################

# Iterate over a list of geohashes (db, versions, extension) and build files with the pattern "ext/siose-xxxx-geohash.ext".
define get-build-rule

## Build one split (e.g. make siose-2005-ezp6.shp).
$1-$2-$3.$4: $(out_dir)/$4/$1-$2-$3.$4

# Group all targets by extension
$4_targets += $(out_dir)/$4/$1-$2-$3.$4

build_targets += $(out_dir)/$4/$1-$2-$3.$4

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

# Compiled in define 


#########
# RULES #
#########

build-all: $(build_targets)

## 'split' in ESRI Shapefiles
build-shps: $(shp_targets)


#################
# PATTERN RULES #
#################
# Zip and remove shp files
#%.shp.zip: %.shp %.dbf %.shx
#	@$(BASH) -c 'cd /$(@D) && zip -q $(@F) $(^F) && rm $(^F)'
#	@$(BASH) -c 'cd /$(@D) && zip -q $(@F) $(^F)'
	

$(shp_dir)/%.shp $(shp_dir)/%.dbf $(shp_dir)/%.shx $(shp_dir)/%.cpg $(shp_dir)/%.prj: $(gh_dir)/%.gh | checkdirs
	@echo -n "Splitting $(@F) ... "
	$(GET_SHP) /$@ $(FROM_SIOSE_2005) $(AS) "SELECT * FROM split_poly_geo('$(lastword $(subst -, ,$(*F)))');"
	@echo "Done."
