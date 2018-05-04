#-----------------------------
# DIRECTORY STRUCTURE (PATHS)
#-----------------------------
out_dir     := out

dirs        := $(out_dir)

# Target for creating all necessary folders
checkdirs: $(dirs)
$(dirs):
	mkdir -p $@
