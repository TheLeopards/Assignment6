library(sp)
library(raster)
library(rgdal)
library(rgeos)


railways <- readOGR("data", layer = "railways")

industrial <- list(railways[railways$type == "industrial"])

industrial




prj_string_WGS <- CRS("+proj=longlat +datum=WGS84")
mypoints <- SpatialPoints(coords, proj4string=prj_string_WGS)







