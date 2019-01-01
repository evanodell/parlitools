

# ccgs --------------------------------------------------------------------

# https://data.gov.uk/dataset/65e57bca-8610-4b33-93cd-10f3acae4983/clinical-commissioning-groups-april-2017-full-clipped-boundaries-in-england-v4/datafile/74e8f5fe-5cfe-4ff9-834d-fc8e8f475ee9/preview

library(sf)
library(geogrid)

ccg_map <- read_sf("./data-raw/Clinical_Commissioning_Groups_April_2016_Generalised_Clipped_Boundaries_in_England", "Clinical_Commissioning_Groups_April_2016_Generalised_Clipped_Boundaries_in_England")


new_cells_hex <- calculate_grid(shape = ccg_map, grid_type = "hexagonal")
resulthex <- assign_polygons(ccg_map, new_cells_hex)



# Creating map labels
labels <- paste0(
  "<strong>", resulthex$ccg16cd, "</strong>", "</br>",
  "Name: ", resulthex$ccg16nm
) %>% lapply(htmltools::HTML)

# Creating the map itself
leaflet(
  options = leafletOptions(
    dragging = FALSE, zoomControl = FALSE, tap = FALSE,
    minZoom = 6, maxZoom = 6, maxBounds = list(list(2.5, -7.75), list(58.25, 50.0)),
    attributionControl = FALSE
  ),
  resulthex
) %>%
  addPolygons(
    color = "grey",
    weight = 0.75,
    opacity = 0.5,
    fillOpacity = 1,
    label = labels
  ) %>%
  htmlwidgets::onRender(
    "function(x, y) {
    var myMap = this;
    myMap._container.style['background'] = '#fff';
    }"
  )
