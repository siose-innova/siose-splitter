
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
# TODO: Ensure that these files exist or can be created from docker

define get-ghlist-rule

# Geohashes of precision $1
gh$1_csv += $(out_dir)/gh$1.csv
gh_csv_lists += $(out_dir)/gh$1.csv

# Get geohashes into variables
# Basic for pulling geohashes
# Get a list of geohashes and remove the column name.
# This only works if gh%_csv already exists.
gh$1 += $$(shell cat $(gh$1_csv))
gh$1 += $$(filter-out $(word 1, $(gh$1)),$(gh$1))
geohashes += gh$1

endef


$(foreach p,$(precisions),\
	$(eval $(call get-ghlist-rule,$(p)))\
)

# DON'T CREATE FILES OUT OF MAKE
# TODO: Lists could be in a single file format
gh_shp_lists := $(gh_csv_lists:%.csv=%.shp)
gh_shp_lists += $(gh_csv_lists:%.csv=%.dbf)
gh_shp_lists += $(gh_csv_lists:%.csv=%.shx)

pull_list_targets := $(gh_shp_lists) $(gh_csv_lists)


#########
# RULES #
#########
# TODO: This could be done by default (inmediately after 'make', not in a rule)
## Pull a list of geohashes from a geohashed docker database.
pull-lists: $(pull_list_targets)


#################
# PATTERN RULES #
#################
$(out_dir)/gh%.csv: | checkdirs
	@echo -n "Pulling list of geohashes (precision '$(*F)')..."
	@$(GET_CSV) /$@ $(FROM_SIOSE_2005) $(AS) "SELECT id FROM gh WHERE precision='$(*F)'"
	@echo "Done."


$(out_dir)/gh%.shp: | checkdirs
	@echo -n "Pulling grid of geohashes (precision '$(*F)')..."
	@$(GET_SHP) /$@ $(FROM_SIOSE_2005) $(AS) "SELECT * FROM gh WHERE precision='$(*F)'"
	@echo "Done."

