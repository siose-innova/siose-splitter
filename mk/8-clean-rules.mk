
define get-clean-rule
## Clean one single image, if it was created by this makefile. Replace $1 by the image name you want to remove (e.g. make clean-image3).
clean-$1: clean-$$(imagename_$1)

clean-$$(imagename_$1):
	@echo 'Cleaning $1...'
	@$(DOCKER_RMI) \
		$1:$(version) \
		$1:latest
	@rm $(stamps_dir)/built-$$(imagename_$1)

clean_targets+= clean-$1

endef


$(foreach x,$(built),\
	$(eval $(call get-clean-rule,$(x)))\
)


# Refs:
# - https://www.calazan.com/docker-cleanup-commands/
# - http://stackoverflow.com/questions/17236796/how-to-remove-old-docker-containers
#	@echo "Remove all non running containers"
#	-docker rm `docker ps -q -f status=exited`
#	@echo "Delete all untagged/dangling (<none>) images"
#	-docker rmi `docker images -q -f dangling=true`

