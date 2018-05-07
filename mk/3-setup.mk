#-----------------------------
# DIRECTORY STRUCTURE (PATHS)
#-----------------------------
out_dir     := outputs

gh_dir      := $(out_dir)/gh

shp_dir     := $(out_dir)/shp
geojson_dir := $(out_dir)/geojson
gpkg_dir    := $(out_dir)/gpkg

dirs        := $(gh_dir) $(shp_dir) $(geojson_dir) $(gpkg_dir)

# Target for creating all necessary folders
checkdirs: $(dirs)
$(dirs):
	mkdir -p $@

