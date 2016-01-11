# Author: The_Leopards (Samantha Krawczyk, Georgios Anastasiou)
# 11th January, 2016

# Assignment 6: Vector operations

library(sp)
library(raster)
library(rgdal)
library(rgeos)

# reading the shapefiles
railways <- readOGR("data", layer = "railways")
city <- readOGR("data", layer = "places")

# selecting railway type = industrial
industrial <- railways[railways$type == "industrial",]

# transforming the pojection to a planar projection
	# define CRS object for RD projection
prj_string_RD <- CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,4.0812 +units=m +no_defs")
	# perform the coordinate transformation from WGS84 to RD
industrialRD <- spTransform(industrial, prj_string_RD)
cityRD <- spTransform(city, prj_string_RD)

# buffering industrial
ind_buffer <- gBuffer(industrialRD, width=1000, byid=TRUE)

# intersecting the buffer and places dataset to find the city and its population 
intersection <- gIntersection(ind_buffer, cityRD)
intersect_log <- gIntersects(ind_buffer, cityRD, byid=TRUE)

city_name <- city$name[intersect_log==TRUE]
city_pop <- city$population[intersect_log==TRUE]

# plotting of the buffer, the points, and the name of the city
plot(ind_buffer, col = c("gray60"))
plot(cityRD, add = TRUE, col="red", pch=19, cex=1.5)
text(cityRD, city$name)
box()

# printing the population of the city (Utrecht)
print(paste("The population of", city_name, "is", city_pop, "people.", sep=" "))



