
# TODO: Watch out! Create a function for this.
# docker = absolute paths; 
# make   = relative paths;

#########
# PATHS #
#########
out_dir     := outputs

gh_dir      := $(out_dir)/gh

shp_dir     := $(out_dir)/shp
geojson_dir := $(out_dir)/geojson
gpkg_dir    := $(out_dir)/gpkg

dirs        := $(gh_dir) $(shp_dir) $(geojson_dir) $(gpkg_dir)


# Target for creating all necessary folders
checkdirs: $(dirs)
$(dirs):
	@$(MKDIR) /$@


###########
# TARGETS #
###########
gh2_csv := $(out_dir)/gh2.csv
gh3_csv := $(out_dir)/gh3.csv
gh4_csv := $(out_dir)/gh4.csv
gh5_csv := $(out_dir)/gh5.csv
gh6_csv := $(out_dir)/gh6.csv

gh_csv_lists := $(gh2_csv) $(gh3_csv) $(gh4_csv) $(gh5_csv) $(gh6_csv)

# DON'T CREATE FILES OUT OF MAKE
# TODO: Lists could be in a single file format
gh_shp_lists := $(gh_csv_lists:%.csv=%.shp)
gh_shp_lists += $(gh_csv_lists:%.csv=%.dbf)
gh_shp_lists += $(gh_csv_lists:%.csv=%.shx)

list_targets := $(gh_shp_lists) $(gh_csv_lists)

# Get a list of geohashes and remove the column name.
gh2 := $(shell cat $(gh2_csv))
gh2 := $(filter-out $(word 1, $(gh2)),$(gh2))

gh3 := $(shell cat $(gh3_csv))
gh3 := $(filter-out $(word 1, $(gh3)),$(gh3))

gh4 := $(shell cat $(gh4_csv))
gh4 := $(filter-out $(word 1, $(gh4)),$(gh4))

gh5 := $(shell cat $(gh5_csv))
gh5 := $(filter-out $(word 1, $(gh5)),$(gh5))

gh6 := $(shell cat $(gh6_csv))
gh6 := $(filter-out $(word 1, $(gh6)),$(gh6))

geohashes := $(gh2) $(gh3) $(gh4) $(gh5) $(gh6)

################
# DEFINE RULES #
################
define get-gh-targets

gh_targets += $(gh_dir)/$1-$2-$3.gh

endef

# Get gh targets
$(foreach db,$(dbs),\
	$(foreach version,$(db_versions),\
		$(foreach geohash,$(geohashes),\
			$(eval $(call get-gh-targets,$(db),$(version),$(geohash)))\
		)\
	)\
)

#################
# SETUP TARGETS #
#################

setup_targets := $(list_targets) $(gh_targets)


#################
# PATTERN RULES #
#################
$(out_dir)/gh%.csv:
	@$(echo) -n "Pulling list of geohashes (precision '$(*F)') ... "
	@$(GET_CSV) /$@ $(FROM_SIOSE_2005) $(AS) "SELECT id FROM gh WHERE precision='$(*F)'"
	@$(echo) "Done."


$(out_dir)/gh%.shp: 
	@$(echo) -n "Pulling grid of geohashes (precision '$(*F)') ... "
	@$(GET_SHP) /$@ $(FROM_SIOSE_2005) $(AS) "SELECT * FROM gh WHERE precision='$(*F)'"
	@$(echo) "Done."

$(gh_dir)/%.gh:
	@$(echo) -n 'Pulling $(@F) ... '
	@$(TOUCH) /$@
	@$(echo) "Done."

