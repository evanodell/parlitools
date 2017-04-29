library(leaflet)
library(sf)
library(dplyr)
library(hansard)
library(mnis)
library(parlitools)
library(cartogram)

west_hex_map <- parlitools::west_hex_map

party_colour <- parlitools::party_colour ## Party colour data

current_mps <- current_mps() 

elect2015 <- election_results(382386) # Get 2015 General Election Results

constits <- constituencies() ### combine with elect 2015 to get gss code

elect2015_details <- left_join(constits, elect2015, by = c("about"= "constituency_about")) ## Join

current_mps_colours <- left_join(current_mps, party_colour, by = "party_id") ## Join to current MP data

west_hex_map <- left_join(west_hex_map, current_mps_colours, by = "gss_code") ## Join to hexagon map

west_hex_map <- left_join(west_hex_map, elect2015_details, by = "gss_code") ## Join together

west_hex_map <- as(west_hex_map, "Spatial")

west_hex_map <- as(west_hex_map, "SpatialPolygonsDataFrame")

west_hex_scaled <- cartogram(west_hex_map, 'majority')

# Creating map labels
labels <- paste0(
  "<strong>", west_hex_scaled$member_from, "</strong>", "</br>",
  west_hex_scaled$party_name, "</br>",
  west_hex_scaled$display_as, "</br>",
  "2015 Result: ", west_hex_scaled$result_of_election, "</br>",
  "2015 Majority: ", west_hex_scaled$majority
) %>% lapply(htmltools::HTML)

# Creating the map itself
leaflet(
  west_hex_scaled) %>%
  addPolygons(
    color = "grey",
    weight=0.75,
    opacity = 0.5,
    fillOpacity = 1,
    fillColor = ~party_colour,
    label=labels) 


west_hex_map <- parlitools::west_hex_map

party_colour <- parlitools::party_colour ## Party colour data

current <- current_mps() 

elect2015 <- election_results(382386) # Get 2015 General Election Results

constits <- constituencies() ### combine with elect 2015 to get gss code

elect2015_details <- left_join(constits, elect2015, by = c("about"= "constituency_about")) ## Join

current_mps_colours <- left_join(current, party_colour, by = "party_id") ## Join to current MP data

west_hex_map <- left_join(west_hex_map, current_mps_colours, by = "gss_code") ## Join to hexagon map

west_hex_map <- left_join(west_hex_map, elect2015_details, by = "gss_code") ## Join together

# Creating map labels
labels <- paste0(
  "<strong>", west_hex_map$member_from, "</strong>", "</br>",
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
