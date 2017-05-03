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
  "2015 Result: ", west_hex_map$result_of_election, "</br>",
  "2015 Majority: ", west_hex_map$majority
) %>% lapply(htmltools::HTML)

# Creating the map itself
leaflet(
  west_hex_map) %>%
  addPolygons(
    color = "grey",
    weight=0.75,
    opacity = 0.5,
    fillOpacity = 1,
    fillColor = ~party_colour,
    label=labels) 
