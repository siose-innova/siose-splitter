
# TODO: Define one clean target for every output format
# TODO: Create maintainers-clean, distclean, etc

.PHONY: clean
## Delete all files created by this Makefile.
clean:
	@echo -n "Deleting all files created by this Makefile... "
	@$(RM) $(addprefix /,$(build_targets))
	@echo "Done."


# Other standard targets

#distclean:

.PHONY: mostlyclean
mostlyclean: clean
	@echo -n "Deleting main files created... "
	@$(RM) $(addprefix /,$(gh_shp_lists))
	@echo "Done."

.PHONY: maintainer-clean
## Delete all files created that can be created by this Makefile (Even docker-compose.yml, etc)
maintainer-clean: mostlyclean
	@echo -n "Deleting all files created by this Makefile... "
	@$(RM) $(addprefix /,$(build_targets)) $(addprefix /,$(build_targets))
	@echo "Done."


