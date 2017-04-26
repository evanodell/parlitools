
# Party Colours -----------------------------------------------------------

  library(readxl)
  party_colour <- read_excel("./data-raw/party_colour.xlsx")
  devtools::use_data(party_colour)

# Maps -----------------------------------------------------------

  library(sf)
  west_hex_map <- read_sf('./data-raw/hex_map', 'hex_map')## The actually working map
  west_hex_map$NAME <- gsub("Boro Const", "", west_hex_map$NAME) ## Removing extra names
  west_hex_map$NAME <- gsub("Co Const", "", west_hex_map$NAME) ## Removing extra names
  names(west_hex_map)[names(west_hex_map)=="NAME"] <- "constituency_name"
  names(west_hex_map)[names(west_hex_map)=="OBJECTID_1"] <- "object_id"
  names(west_hex_map)[names(west_hex_map)=="DESCRIPTIO"] <- "description"
  names(west_hex_map)[names(west_hex_map)=="CODE"] <- "gss_code"
  names(west_hex_map)[names(west_hex_map)=="Region_Nam"] <- "region_name"
  names(west_hex_map)[names(west_hex_map)=="Shape_Leng"] <- "shape_length"
  names(west_hex_map)[names(west_hex_map)=="Shape_Area"] <- "shape_area"
  devtools::use_data(west_hex_map)
  
# British Election Study Data -----------------------------------------------------------

  library(haven)
  bes_2015 <- read_dta("./data-raw/BES-2015-General-Election-results-file-v2.2.dta")
  names(bes_2015) <- gsub("([[:lower:]])([[:upper:]])", "\\1_\\2", names(bes_2015))
  names(bes_2015) <- gsub(" ", "_", names(bes_2015))
  names(bes_2015) <- tolower(names(bes_2015))
  names(bes_2015) <- gsub("([[:digit:]])([[:lower:]])", "\\1_\\2", names(bes_2015))
  names(bes_2015) <- gsub("([[:lower:]])([[:digit:]])", "\\1_\\2", names(bes_2015))
  devtools::use_data(bes_2015)
