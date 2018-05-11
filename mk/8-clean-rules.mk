
# TODO: Define one clean target for every output format
# TODO: Create maintainers-clean, distclean, etc

.PHONY: clean
## Delete all files created by this Makefile.
clean:
	@echo -n "Deleting all files created by this Makefile... "
	@rm -rf $(gh_dir)/* $(shp_dir)/*
	@echo "Done."


# Other standard targets

#distclean:

#mostlyclean:

#maintainer-clean:


