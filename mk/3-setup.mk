
# Watch out!
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

##############
# Main files #
##############
# TODO: See the example
#gh2 := xx
#gh3 := xxx
#gh4 := xxxx
#gh5 := xxxxx
#gh6 := xxxxxx
#gh7 := xxxxxxx
#geohashes := $(gh2) $(gh3) $(gh4) $(gh5) $(gh6)

# TODO: Ensure that these files exist or can be created from docker
gh_list := $(out_dir)/gh-list.csv

###########
# TARGETS #
###########
gh_list_targets += $(gh_list)
pull_targets += $(gh_list)

#########
# RULES #
#########
# TODO: This could be done by default (inmediately after 'make', not in a rule)
## Pull a list of geohashes from a geohashed docker database.
pull-list: $(gh_list)

$(gh_list): | checkdirs
	@echo -n 'Pulling a list of geohashes...'
	@$(DOCKER_EXEC) -it $(OGR2OGR_CONTAINER) \
	$(OGR2OGR) \
	-f "CSV" /$@ \
	PG:"postgresql://postgres:postgres@dbm/db" \
	-sql "SELECT id FROM gh"
	@echo "Done."

# Get a list of geohashes and remove the column name.
# This only works if gh-list already exists.
geohashes := $(shell cat $(gh_list))
geohashes := $(filter-out $(word 1, $(geohashes)),$(geohashes))


#################
# PATTERN RULES #
#################


