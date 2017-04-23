
# Party Colours -----------------------------------------------------------

  library(readxl)
  party_colour <- read_excel("./data-raw/party_colour.xlsx")
  devtools::use_data(party_colour)

# Maps -----------------------------------------------------------

  library(sf)
  west_hex_map <- read_sf('./data-raw/hex_map', 'hex_map')## The actually working map
  devtools::use_data(west_hex_map)
  
  
  
# British Election Study Data -----------------------------------------------------------

  library(haven)
  bes_2015 <- read_dta("~/Documents/GitHub/parlitools/data-raw/BES-2015-General-Election-results-file-v2.2.dta")
  devtools::use_data(bes_2015)
  
  