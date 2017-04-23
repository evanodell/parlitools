
%>%
  addLabelOnlyMarkers(
    data=sf_NPR1to1.centers,
    label = ~as.character(state),
    labelOptions = labelOptions(
      noHide = 'T', textOnly = T,
      offset=c(-4,-10), textsize = '12px')) %>%
  setMapWidgetStyle()

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
  addPolygons(data=parlitools::west_hex_map, group = "CODE")



leaflet(
  options= getLeafletOptions(7, 7)) %>%
  addPolygons(
    data=west_hex_map3, group = "CODE",
    weight=2,color='#000000', opacity = 1,
    highlightOptions = highlightOptions(weight = 4))  %>%
  addPolygons(
    data=west_hex_map3,
    weight=1,color='#000000', opacity=1, fillOpacity = 1,
    options = pathOptions(clickable = FALSE, pointerEvents = 'none')) %>%
  addLabelOnlyMarkers(
    data=west_hex_map3,
    labelOptions = labelOptions(
      noHide = 'T', textOnly = T,
      offset=c(-4,-10), textsize = '12px',
      style=list('color'='#000000'))) %>%
  setMapWidgetStyle()


leaflet(
  options= getLeafletOptions(7, 7)) %>%
  addPolygons(
    data=sf_NPR1to1, group = "CODE",
    weight=2,color='#000000', opacity = 1,
    highlightOptions = highlightOptions(weight = 4))  %>%
  addPolygons(
    data=sf_NPR1to1,
    weight=1,color='#000000', opacity=1, fillOpacity = 1,
    options = pathOptions(clickable = FALSE, pointerEvents = 'none')) %>%
  addLabelOnlyMarkers(
    data=sf_NPR1to1,
    labelOptions = labelOptions(
      noHide = 'T', textOnly = T,
      offset=c(-4,-10), textsize = '12px',
      style=list('color'='#000000'))) %>%
  setMapWidgetStyle()


 %>%
  addLabelOnlyMarkers(
    data=sf_NPR1to1.centers,
    label = ~as.character(state),
    labelOptions = labelOptions(
      noHide = 'T', textOnly = T,
      offset=c(-4,-10), textsize = '12px')) %>%
  setMapWidgetStyle()


