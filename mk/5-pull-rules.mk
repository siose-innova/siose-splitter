
################
# DEFINE RULES #
################

define get-pull-rule
## Pull one single geohash (e.g. make pull-siose-2005-ezp6.gh).
pull-$1-$2-$3: $(gh_dir)/$1-$2-$3.gh

$(gh_dir)/$1-$2-$3.gh:
	@echo -n 'Pulling $1-$2-$3.gh...'
	@touch $$@
	@echo "Done."

gh_targets += $(gh_dir)/$1-$2-$3.gh

endef



# Get pull rules
$(foreach db,$(dbs),\
	$(foreach version,$(db_versions),\
		$(foreach geohash,$(geohashes),\
			$(eval $(call get-pull-rule,$(db),$(version),$(geohash)))\
		)\
	)\
)


###########
# TARGETS #
###########

pull_targets += $(gh_targets)


#########
# RULES #
#########

## Pull all geohashes from the server.
pull-geohashes: $(gh_targets)


#################
# PATTERN RULES #
#################



