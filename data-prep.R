

library(sp)  # vector data
library(raster)  # raster data
library(rgdal)  # input/output, projections
library(rgeos)  # geometry ops
library(spdep)  # spatial dependence
library(sf)

latlong = "+init=epsg:4326"

proj4string(west_hex_map2) <- NA

  west_hex_map <- rgdal::readOGR("./data/GB_Hex_Cartogram_Const.shp", "GB_Hex_Cartogram_Const")

  
  west_hex_map2 <- read_sf('./data-raw/GB_Hex_Cartogram_Const', 'GB_Hex_Cartogram_Const')
  
  sf_NPR1to1 <- read_sf('./data-raw/NPR1to1', 'NPR1to1')
  
  test <- read_sf('./data-raw/test', 'test')
  
  
  st_geometry(west_hex_map2)
  
  st_geometry(sf_NPR1to1)
  
  devtools::use_data(west_hex_map)

  electionResults <- election_results()
  
  constituencies <- constituencies()

library(stringr)
  library(tidyverse)
  library(leaflet)
  
  election.2015 <- electionResults %>% 
    filter(election_label_value=="2015 General Election")  %>%  
    left_join(constituencies,by=c("constituency_label_value"="label_value")) %>% 
    mutate(victory_pc=round(100*majority/turnout,1))
  
  
  election.2015$party <- election.2015$result_of_election %>% 
    map(str_split, pattern = " ") %>% 
    map_chr(c(1,1))
  
  
  west_hex_map2 %>% st_crs(west_hex_map2) %>% st_transform(proj4string = "+init=epsg:4326")
  
  
  west_hex_map2 %>% st_transform(structure(west_hex_map2, proj4string = "+init=epsg:4326"), "+init=epsg:3857")
  
  map = parlitools::west_hex_map
  
  
  map@data <- 
    map@data %>% 
    left_join(election.2015,by=c("CODE"="gss_code"))
  
 

  
  suppressPackageStartupMessages(library(tilegramsR))
  library(leaflet)
  devtools::install_github('rstudio/leaflet')
  devtools::install_github('bhaskarvk/leaflet.extras')
  library(leaflet.extras)
  
  getLeafletOptions <- function(minZoom, maxZoom, ...) {
    leafletOptions(
      crs = leafletCRS("L.CRS.Simple"),
      minZoom = minZoom, maxZoom = maxZoom,
      dragging = FALSE, zoomControl = FALSE,
      tap = FALSE,
      attributionControl = FALSE , ...)
  }
  
  getFactorPal <- function(f) {
    colorFactor(colormap::colormap(
      colormap = colormap::colormaps$hsv,
      nshades = length(f)), f)
  }
    
  
  leaflet() %>%
    addPolygons(data=west_hex_map2, group = "CODE")
  
  
  
  leaflet(
    options= getLeafletOptions(7, 7)) %>%
    addPolygons(
      data=west_hex_map2, group = "CODE",
      weight=2,color='#000000', opacity = 1,
      highlightOptions = highlightOptions(weight = 4))  %>%
    addPolygons(
      data=west_hex_map2,
      weight=1,color='#000000', opacity=1, fillOpacity = 1,
      options = pathOptions(clickable = FALSE, pointerEvents = 'none')) %>%
    addLabelOnlyMarkers(
      data=west_hex_map2,
      labelOptions = labelOptions(
        noHide = 'T', textOnly = T,
        offset=c(-4,-10), textsize = '12px',
        style=list('color'='#000000'))) %>%
    setMapWidgetStyle()
  
  
  
  west_hex_map2 <- st_transform(structure(west_hex_map2, proj4string = NA), "+init=epsg:3857")
  
  nc.web_mercator <- st_transform(west_hex_map2, 3857)
  
  st_geometry(west_hex_map2)
  
  st_geometry(sf_NPR1to1)
  
  west_hex_map2$geometry$proj4string <-NA
  
  plot(west_hex_map2)
  
  
  west_hex_map2_centres <- st_centroid(west_hex_map2)

  
  leaflet(west_hex_map2)  
  
  