
# TODO: push splits to the fileserver (it requires a previous 'build')

define get-push-rule
## Push one split to the fileserver (e.g. make push-image3).
push-$1: 

push_targets+= push-$1

endef



# push from library to DockerHub
$(foreach x,$(splits),\
	$(eval $(call get-push-rule,$(x)))\
)

