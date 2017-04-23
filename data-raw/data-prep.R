
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
  bes_2015 <- read_dta("./data-raw/BES-2015-General-Election-results-file-v2.2.dta")
  names(bes_2015) <- gsub("([[:lower:]])([[:upper:]])", "\\1_\\2", names(bes_2015))
  names(bes_2015) <- gsub(" ", "_", names(bes_2015))
  names(bes_2015) <- tolower(names(bes_2015))
  names(bes_2015) <- gsub("([[:digit:]])([[:lower:]])", "\\1_\\2", names(bes_2015))
  names(bes_2015) <- gsub("([[:lower:]])([[:digit:]])", "\\1_\\2", names(bes_2015))
  devtools::use_data(bes_2015)

# Electoral Spending ------------------------------------------------------
  
  library(readr)
  ## 2001 UK General Election
  spending_2001 <- read_csv("./data-raw/spending/2001-UK-Parliament-spending-data-CSV.csv")
  names(spending_2001) <- gsub("([[:lower:]])([[:upper:]])", "\\1_\\2", names(spending_2001))
  names(spending_2001) <- gsub(" ", "_", names(spending_2001))
  names(spending_2001) <- tolower(names(spending_2001))
  devtools::use_data(spending_2001)
  
  ## 2005 UK General Election
  spending_2005 <- read_csv("./data-raw/spending/2005-UK-Parliament-spending-data-CSV.csv")
  names(spending_2005) <- gsub("([[:lower:]])([[:upper:]])", "\\1_\\2", names(spending_2005))
  names(spending_2005) <- gsub(" ", "_", names(spending_2005))
  names(spending_2005) <- tolower(names(spending_2005))
  devtools::use_data(spending_2005)
  
  ## 2010 UK General Election
  spending_2010 <- read_csv("./data-raw/spending/2010-UK-Parliament-spending-data-CSV.csv")
  names(spending_2010) <- gsub("([[:lower:]])([[:upper:]])", "\\1_\\2", names(spending_2010))
  names(spending_2010) <- gsub(" ", "_", names(spending_2010))
  names(spending_2010) <- tolower(names(spending_2010))
  devtools::use_data(spending_2010)
  
  ## 2015 UK General Election
  library(readxl)
  spending_2015 <- read_excel("~/Documents/GitHub/parlitools/data-raw/spending/2015-UK-Parliament-spending-data.xlsx")
  names(spending_2015) <- gsub("([[:lower:]])([[:upper:]])", "\\1_\\2", names(spending_2015))
  names(spending_2015) <- gsub(" ", "_", names(spending_2015))
  names(spending_2015) <- tolower(names(spending_2015))
  devtools::use_data(spending_2015)
  

# Brexit data -------------------------------------------------------------

### In data-raw folder, still needs some cleaning