library(leaflet)
library(sf)
library(dplyr)
library(hansard)

west_hex_map <- parlitools::west_hex_map #Base map

trump_no <- epetition(ID = 648278, by_constituency=TRUE) #Download anti-inviting Trump signatures

west_trump_no <- left_join(west_hex_map, trump_no, by = "gss_code") #Joining to base map

pal = colorNumeric("Blues", trump_no$number_of_signatures)

label_no <- paste0(
  "<strong>", west_trump_no$constituency_name, "</strong>", "</br>",
  "Signatures: ", west_trump_no$number_of_signatures
) %>% lapply(htmltools::HTML)

leaflet(options=leafletOptions(
  dragging = FALSE, zoomControl = FALSE,
  minZoom = 6, maxZoom = 6,
  attributionControl = FALSE),
  west_trump_no) %>%
  addPolygons(
    color = "grey",
    weight=0.75,
    opacity = 0.5,
    fillOpacity = 1,
    fillColor = ~pal(number_of_signatures),
    label = label_no) %>%
  addLegend("topright", pal = pal, values = ~number_of_signatures,
            title = "Number of Signatures",
            opacity = 1) %>% 
  htmlwidgets::onRender(
    "function(x, y) {
        var myMap = this;
        myMap._container.style['background'] = '#fff';
    }")%>% 
  mapOptions(zoomToLimits = "first")
