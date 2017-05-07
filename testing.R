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
map <- leaflet(options=leafletOptions(
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


bounds <- input$mymap_bounds
latRng <- range(bounds$north, bounds$south)
lngRng <- range(bounds$east, bounds$west)

library(tilegramsR)
library(leaflet)
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

leaflet(
  tilegramsR:: sf_NPR1to1,
  options= getLeafletOptions(-1.5, -1.5)) %>%
  addPolygons(
    weight=2,color='#000000', group = 'states',
    fillOpacity = 0.6, opacity = 1, fillColor= ~getFactorPal(state)(state),
    highlightOptions = highlightOptions(weight = 4)) %>%
  addLabelOnlyMarkers(
    data=sf_NPR1to1.centers,
    label = ~as.character(state),
    labelOptions = labelOptions(
      noHide = 'T', textOnly = T,
      offset=c(-4,-10), textsize = '12px'))
