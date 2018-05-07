
#---------------
# CLEAN TARGETS
#---------------

.PHONY: clean
## Delete all files created by this Makefile.
clean:
	# Docker PWD vs host ./outputs
	@echo -n "Deleting all files created by this Makefile... "
	@$(DOCKER_EXEC) -it $(OGR2OGR_CONTAINER) \
	rm -rf $(notdir $(pull_targets))
	@echo "Done."
