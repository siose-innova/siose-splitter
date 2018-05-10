
# TODO: Watch out! Create a function for this.
# docker = absolute paths; 
# make   = relative paths;

#-----------------------------
# DIRECTORY STRUCTURE (PATHS)
#-----------------------------
out_dir     := outputs

gh_dir      := $(out_dir)/gh

shp_dir     := $(out_dir)/shp
geojson_dir := $(out_dir)/geojson
gpkg_dir    := $(out_dir)/gpkg

dirs        := $(gh_dir) $(shp_dir) $(geojson_dir) $(gpkg_dir)


# Target for creating all necessary folders
checkdirs: $(dirs)
$(dirs):
	mkdir -p $@


###########
# TARGETS #
###########
# TODO: Ensure that these files exist or can be created from docker
# TODO: Convert to define?
gh2_csv := $(out_dir)/gh2.csv
gh3_csv := $(out_dir)/gh3.csv
gh4_csv := $(out_dir)/gh4.csv
gh5_csv := $(out_dir)/gh5.csv
gh6_csv := $(out_dir)/gh6.csv

gh_csv_targets += $(gh2_csv) $(gh3_csv) $(gh4_csv) $(gh5_csv) $(gh6_csv)

pull_targets += $(gh_csv_targets)

#########
# RULES #
#########
# TODO: This could be done by default (inmediately after 'make', not in a rule)
## Pull a list of geohashes from a geohashed docker database.
pull-lists: $(gh_csv_targets)


# Get a list of geohashes and remove the column name.
# This only works if gh%_csv already exists.
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

#################
# PATTERN RULES #
#################
$(out_dir)/gh%.csv: | checkdirs
	@echo -n "Pulling list of geohashes (precision '$(*F)')..."
	@$(GET_CSV) /$@ $(FROM_SIOSE_2005) $(AS) "SELECT id FROM gh WHERE precision='$(*F)'"
	@echo "Done."

