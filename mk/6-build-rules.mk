
# TODO: Iterate over a list of geohashes (versions, extension) and build files with the pattern "siose-xxxx-geohash.ext".

define get-build-rule
## Build one split. Replace $1 by ... you want to build (e.g. make build-...).
build-$1: 

build_targets+= build-$1

endef

## TODO: Triple loop version -> geohash -> extension
$(foreach x,$(images),\
	$(eval $(call get-build-rule,$(x)))\
)

