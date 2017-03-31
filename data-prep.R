


library(rgeos)
library(maptools)
library(gpclib)

map4 <- rgdal::readOGR("./data/GB_Hex_Cartogram_Const.shp", "GB_Hex_Cartogram_Const")


library(leaflet)

head(map4@data)




if(hex_map=TRUE){
  map2 <- rgdal::readOGR("./data/GB_Hex_Cartogram_Const.shp")
} else {
  map3 <- rgdal::readOGR("./data/westminster_2010_2015_cart.kml")
}  

x <- constituencies()

y <- election_results(ID = 382386)

test5 <- left_join(y, x, by = c("constituency_about"= "about"))



elections()
