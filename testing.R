library(leaflet)
library(sf)
library(dplyr)
library(hansard)
library(mnis)
library(sp)
library(sf)
library(methods)

west_hex_map <- parlitools::west_hex_map

install.packages("cartogram")



party_colour <- parlitools::party_colour ## Party colour data

current_mps <- current_mps() 

elect2015 <- election_results(382386) # Get 2015 General Election Results

current_mps_colours <- left_join(current_mps, party_colour, by = "party_id") ## Join to current MP data

west_hex_map2 <- left_join(west_hex_map, current_mps_colours, by = "gss_code") ## Join to hexagon map

west_hex_map2 <- left_join(west_hex_map2, elect2015, by = c("about"= "constituency_about")) ## Join together


current$member_from[468]

