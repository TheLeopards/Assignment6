library(sp)
library(raster)
library(rgdal)
library(rgeos)


railways <- readOGR("data", layer = "railways")

industrial <- railways[railways$type == "industrial",]

industrial


ind_buffer <- gBuffer(industrial, width=1000, byid=TRUE)


Buffers the "industrial" railways with a buffer
of 1000m (hint: gBuffer with byid=TRUE)





