
# Fileserver where splits are published
fileserver := sigua.ua.es...

# List of formats supported by GDAL/OGR to be created
formats := shp #gpkg geojson

# List files to be used as ROIs
castellon := castellon.zip
rois := $(castellon)

# List SIOSE years to be processed
version := 2005 #2011 2014

# Manually set these lists or query from the database
geohash_2 := xx
geohash_3 := xxx
geohash_4 := xxxx
geohash_5 := xxxxx
geohash_6 := xxxxxx
geohash_7 := xxxxxxx

geohashes := $(geohash_3)


# TODO: define splits?
define get-split

splits+= $1-$2-$3

endef



# TODO: triple loop siose-ver-geohash.extension
$(foreach x,$(version),\


	$(eval $(call get-splits,$(x)))\


)



