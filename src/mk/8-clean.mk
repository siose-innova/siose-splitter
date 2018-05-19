
#TODO: This way, clean fails if targets dont exist.
#TODO: Clean should work after stopping services. We could use docker run.

.PHONY: clean
## Delete all files created by this Makefile.
clean:
	@echo -n "Deleting all files created by 'make all' ... "
	@$(RM) $(addprefix /,$(setup_targets)) \
		$(addprefix /,$(build_targets))
	@echo "Done."


# Other standard targets
#distclean:

.PHONY: mostlyclean
## Like ‘clean’, but may refrain from deleting a few files like (e.g. docker-compose.yml, gh-lists, ghs, etc).
mostlyclean:
	@echo -n "Deleting builds and dist... "
	@$(RM) $(addprefix /,$(build_targets))
	@echo "Done."

.PHONY: maintainer-clean
## Delete almost everything that can be reconstructed with this Makefile.
maintainer-clean: $()
	@echo -n "Deleting all files created by this Makefile... "
	@$(RM) $(addprefix /,$(setup_targets)) \
		$(addprefix /,$(build_targets)) \
		$(addprefix /,$(dirs))
	@echo "Done."
	@echo "Stopping and removing all services... "
	@docker-compose -f $(compose) down -v && rm $(compose)
	@echo "Done."
	@echo ""
	@echo "Everything was removed."
	@echo "Now you have to 'make all' or 'make start-services' in order to start from the begining."
	@echo ""



