#-----------------------------
# DIRECTORY STRUCTURE (PATHS)
#-----------------------------
out_dir     := out

shp_dir     := $(out_dir)/shp
geojson_dir := $(out_dir)/geojson
gpkg_dir    := $(out_dir)/gpkg

dirs        := $(shp_dir) $(geojson_dir) $(gpkg_dir)

# Target for creating all necessary folders
checkdirs: $(dirs)
$(dirs):
	mkdir -p $@
