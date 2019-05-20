# Maps -----------------------------------------------------------

## Constituencies ---------------------
library(sf)
west_hex_map <- read_sf("./data-raw/west_hex_map", "west_hex_map")
west_hex_map$NAME <- gsub("Boro Const", "", west_hex_map$NAME) ## Removing extra names
west_hex_map$NAME <- gsub("Co Const", "", west_hex_map$NAME) ## Removing extra names
west_hex_map$NAME <- gsub("Burgh Const", "", west_hex_map$NAME) ## Removing extra names
names(west_hex_map)[names(west_hex_map) == "NAME"] <- "constituency_name"
names(west_hex_map)[names(west_hex_map) == "OBJECTID_1"] <- "object_id"
names(west_hex_map)[names(west_hex_map) == "DESCRIPTIO"] <- "description"
names(west_hex_map)[names(west_hex_map) == "CODE"] <- "gss_code"
names(west_hex_map)[names(west_hex_map) == "Region_Nam"] <- "region_name"
names(west_hex_map)[names(west_hex_map) == "Shape_Leng"] <- "shape_length"
names(west_hex_map)[names(west_hex_map) == "Shape_Area"] <- "shape_area"
west_hex_map$constituency_name <- trimws(west_hex_map$constituency_name, which = "right")
usethis::use_data(west_hex_map, overwrite = TRUE)

## Local Authorities map ---------------------
library(sf)
local_hex_map <- read_sf("./data-raw/local_hex_map", "local_hex_map")
names(local_hex_map)[names(local_hex_map) == "OBJECTID"] <- "object_id"
names(local_hex_map)[names(local_hex_map) == "NAME"] <- "constituency_name"
names(local_hex_map)[names(local_hex_map) == "LAD12CD"] <- "la_code"
names(local_hex_map)[names(local_hex_map) == "LAD12NM"] <- "la_name"
names(local_hex_map)[names(local_hex_map) == "Shape_Leng"] <- "shape_length"
names(local_hex_map)[names(local_hex_map) == "Shape_Area"] <- "shape_area"
local_hex_map <- st_zm(local_hex_map, drop = TRUE, what = "ZM")
local_hex_map$la_name <- gsub(
  "Rhondda Cynon Taf", "Rhondda Cynon Taff",
  local_hex_map$la_name
)
local_hex_map$la_name <- gsub(
  "Kingston upon Hull, City of",
  "Kingston upon Hull", local_hex_map$la_name
)
local_hex_map$la_name <- gsub(
  "Shepway",
  "Folkestone and Hythe", local_hex_map$la_name
)
local_hex_map$la_name <- gsub(
  "Aberdeen City",
  "Aberdeen", local_hex_map$la_name
)
local_hex_map$la_name <- gsub(
  "Dundee City",
  "Dundee", local_hex_map$la_name
)

usethis::use_data(local_hex_map, overwrite = TRUE)
