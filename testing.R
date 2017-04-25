

trump_yes <- jsonlite::fromJSON("https://petition.parliament.uk/petitions/178844.json", flatten = TRUE)
trump_yes_con <- trump_yes$data$attributes$signatures_by_constituency

pal = colorNumeric("Oranges", trump_yes_con$signature_count)

west_hex_map <- parlitools::west_hex_map

west_trump_yes <- left_join(west_hex_map, trump_yes_con, by = c("gss_code"="ons_code")) ## Join to hexagon map


labels <- paste0(
  "<strong>", west_trump_yes$constituency_name, "</strong>", "</br>",
  "Signatures: ", west_trump_yes$signature_count
) %>% lapply(htmltools::HTML)

leaflet(
  west_hex_map2) %>%
  addPolygons(
    color = "grey",
    weight=0.75,
    opacity = 0.5,
    fillOpacity = 1,
    fillColor = ~pal(signature_count),
    label = labels)
