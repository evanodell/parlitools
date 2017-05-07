library(leaflet)
library(sf)
library(dplyr)
library(hansard)
library(mnis)
library(parlitools)
library(cartogram)

west_hex_map <- parlitools::west_hex_map

party_colour <- parlitools::party_colour

elect2015 <- parlitools::bes_2015

elect2015_win_colours <- left_join(elect2015, party_colour, by = c("winner_15" ="party_name")) #Join to current MP data

gb_hex_map <- right_join(west_hex_map, elect2015_win_colours, by = c("gss_code"="onsconst_id")) #Join colours to hexagon map

gb_hex_map <- as(gb_hex_map, "Spatial")

gb_hex_map <- as(gb_hex_map, "SpatialPolygonsDataFrame")

gb_hex_map$majority_15 <- round(gb_hex_map$majority_15, 2)

gb_hex_map$turnout_15 <- round(gb_hex_map$turnout_15, 2)

gp_hex_scaled <- cartogram(gb_hex_map, 'majority_15')

# Creating map labels
labels <- paste0(
  "<strong>", "Constituency: ", gb_hex_map$constituency_name.y, "</strong>", "</br>",
  'Turnout: ', gb_hex_map$turnout_15, "</br>",
  "Most Recent Winner: ", gb_hex_map$winner_15, "</br>",
  "Most Recent Majority: ", gb_hex_map$majority_15
) %>% lapply(htmltools::HTML)

# Creating the map itself
leaflet(options=leafletOptions(
  dragging = FALSE, zoomControl = FALSE, tap = FALSE,
  minZoom = 6, maxZoom = 6, maxBounds = list(list(2.5,-7.75),list(58.25,50.0)),
  attributionControl = FALSE),
  gb_hex_map) %>%
  addPolygons(
    color = "grey",
    weight=0.75,
    opacity = 0.5,
    fillOpacity = 1,
    fillColor = ~party_colour,
    label=labels)  %>% 
  htmlwidgets::onRender(
    "function(x, y) {
    var myMap = this;
    myMap._container.style['background'] = '#fff';
    }")%>% 
  mapOptions(zoomToLimits = "first")



library(leaflet)
library(sf)
library(dplyr)
library(hansard)
library(mnis)
library(parlitools)

west_hex_map <- parlitools::west_hex_map

party_colour <- parlitools::party_colour

mps <- mps_on_date("2017-04-19")

mps_colours <- left_join(mps, party_colour, by = "party_id") #Join to current MP data

west_hex_map <- left_join(west_hex_map, mps_colours, by = "gss_code") #Join colours to hexagon map

# Creating map labels
labels <- paste0(
  "<strong>", west_hex_map$constituency_name, "</strong>", "</br>",
  west_hex_map$party_name, "</br>",
  west_hex_map$display_as, "</br>",
  "Most Recent Result: ", west_hex_map$result_of_election, "</br>",
  "Current Majority: ", west_hex_map$majority
) %>% lapply(htmltools::HTML)

# Creating the map itself
leaflet(options=leafletOptions(
  dragging = FALSE, zoomControl = FALSE, tap = FALSE,
  minZoom = 6, maxZoom = 6, maxBounds = list(list(2.5,-7.75),list(58.25,50.0)),
  attributionControl = FALSE),
  west_hex_map) %>%
  addPolygons(
    color = "grey",
    weight=0.75,
    opacity = 0.5,
    fillOpacity = 1,
    fillColor = ~party_colour,
    label=labels)  %>% 
  htmlwidgets::onRender(
    "function(x, y) {
    var myMap = this;
    myMap._container.style['background'] = '#fff';
    }")
