
# TODO: See the example
#gh2 := xx
#gh3 := xxx
#gh4 := xxxx
#gh5 := xxxxx
#gh6 := xxxxxx
#gh7 := xxxxxxx
#geohashes := $(gh2) $(gh3) $(gh4) $(gh5) $(gh6) 

## Pull a list of geohashes from a geohashed docker database.
pull-gh-list: $(out_dir)/gh-list.csv

$(out_dir)/gh-list.csv: | checkdirs
	@echo 'Pulling a list of geohashes...'
	@$(DOCKER_EXEC) -it $(OGR2OGR_CONTAINER) \
	$(OGR2OGR) \
	-f "CSV" $(@F) \
	PG:"postgresql://postgres:postgres@dbm/db" \
	-sql "SELECT id FROM gh"

pull_list_targets := $(out_dir)/gh-list.csv

# Get a list of geohases and remove the column name
geohashes := $(shell cat $(out_dir)/gh-list.csv)
geohashes := $(filter-out $(word 1, $(geohashes)),$(geohashes))


define get-pull-rule
## Pull one single geohash. Replace $1 by the geohash you want to pull (e.g. make pull-ezp6).
pull-$1: $(gh_dir)/$1.gh

$(gh_dir)/$1.gh:
	@echo 'Pulling $1...'
	@touch $$@

pull_gh_targets += $(gh_dir)/$1.gh

endef


# Build rules
$(foreach x,$(geohashes),\
	$(eval $(call get-pull-rule,$(x)))\
)


pull_targets := $(pull_list_targets) $(pull_gh_targets)
