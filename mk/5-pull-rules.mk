
# TODO: Pull ROIs and load them to the siose DB
#geohash_2 := xx
#geohash_3 := xxx
#geohash_4 := xxxx
#geohash_5 := xxxxx
#geohash_6 := xxxxxx
#geohash_7 := xxxxxxx

define get-pull-rule
## Pull one single image. Replace $1 by the image name you want to pull (e.g. make pull-alpine).
pull-$1: $(stamps_dir)/pull-$1

$(stamps_dir)/pulled-$1: | checkdirs
	@echo 'Pulling $1...'
	@$(DOCKER_PULL) $1
	@touch $$@

pull_targets+= $(stamps_dir)/pulled-$1

endef

# Pull ROIs and
# Pull from DockerHub
$(foreach x,$(from_dockerhub),\
	$(eval $(call get-pull-rule,$(x)))\
)


