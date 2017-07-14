
# Party Colours -----------------------------------------------------------

  library(readxl)
  party_colour <- read_excel("./data-raw/party_colour.xlsx")
  party_colour$party_name <- as.factor(party_colour$party_name)
  party_colour$party_id <- as.factor(party_colour$party_id)
  devtools::use_data(party_colour, overwrite = TRUE)

# Maps -----------------------------------------------------------

## Constituencies ---------------------
  
  library(sf)
  west_hex_map <- read_sf('./data-raw/west_hex_map', 'west_hex_map')
  west_hex_map$NAME <- gsub("Boro Const", "", west_hex_map$NAME) ## Removing extra names
  west_hex_map$NAME <- gsub("Co Const", "", west_hex_map$NAME) ## Removing extra names
  west_hex_map$NAME <- gsub("Burgh Const", "", west_hex_map$NAME) ## Removing extra names
  names(west_hex_map)[names(west_hex_map)=="NAME"] <- "constituency_name"
  names(west_hex_map)[names(west_hex_map)=="OBJECTID_1"] <- "object_id"
  names(west_hex_map)[names(west_hex_map)=="DESCRIPTIO"] <- "description"
  names(west_hex_map)[names(west_hex_map)=="CODE"] <- "gss_code"
  names(west_hex_map)[names(west_hex_map)=="Region_Nam"] <- "region_name"
  names(west_hex_map)[names(west_hex_map)=="Shape_Leng"] <- "shape_length"
  names(west_hex_map)[names(west_hex_map)=="Shape_Area"] <- "shape_area"
  west_hex_map$constituency_name <- trimws(west_hex_map$constituency_name, which = "right")
  devtools::use_data(west_hex_map, overwrite = TRUE)
  
  
  ## Local Authorities ---------------------
  library(sf)
  local_hex_map <- read_sf('./data-raw/local_hex_map', 'local_hex_map')
  names(local_hex_map)[names(local_hex_map)=="OBJECTID"] <- "object_id"
  names(local_hex_map)[names(local_hex_map)=="NAME"] <- "constituency_name"
  names(local_hex_map)[names(local_hex_map)=="LAD12CD"] <- "la_code"
  names(local_hex_map)[names(local_hex_map)=="LAD12NM"] <- "la_name"
  names(local_hex_map)[names(local_hex_map)=="Shape_Leng"] <- "shape_length"
  names(local_hex_map)[names(local_hex_map)=="Shape_Area"] <- "shape_area"
  local_hex_map$la_name <- gsub("Rhondda Cynon Taf", "Rhondda Cynon Taff", local_hex_map$la_name)
  devtools::use_data(local_hex_map, overwrite = TRUE) 

# Datasets ---------------------  

## British Election Study Data 2015 -----------------------------------------------------------

  library(readxl)
  bes_2015 <- read_xlsx("./data-raw/BES-2015-General-Election-results-file-v2.21.xlsx")
  facs <- c('Country' ,'ConstituencyName', 'Region', 'ConstituencyType', 'Winner15', 'Winner10', 'SeatChange1015', "ConPPC", "ConPPCsex", "ConPPCrace", "LabPPC", "LabPPCsex", "LabPPCrace", "LDPPC", "LDPPCsex",  "LDPPCrace", "UKIPPPC", "UKIPPPCsex", "UKIPPPCrace", "SNPPPC", "SNPPPCsex", "SNPPPCrace", "PCPPC", "PCPPCsex", "PCPPCrace", "GreenPPC", "GreenPPCsex", "GreenPPCrace")
  bes_2015[,facs] <- lapply(bes_2015[,facs], factor)
  names(bes_2015) <- gsub("([[:lower:]])([[:upper:]])", "\\1_\\2", names(bes_2015))
  names(bes_2015) <- gsub(" ", "_", names(bes_2015))
  names(bes_2015) <- tolower(names(bes_2015))
  names(bes_2015) <- gsub("([[:digit:]])([[:lower:]])", "\\1_\\2", names(bes_2015))
  names(bes_2015) <- gsub("([[:lower:]])([[:digit:]])", "\\1_\\2", names(bes_2015))
  nums <- c("snplong_spend_percent", "snpshort_spend_percent", "pclong_spend_percent", "pcshort_spend_percent")
  bes_2015[,nums] <- lapply(bes_2015[,nums], as.numeric)
  bes_2015$winner_15 <- factor(bes_2015$winner_15, levels=c("Conservative", "Green", "Independent", "Labour", "Liberal Democrat", "Other", "Plaid Cymru", "Scottish National Party", "UKIP"))
  bes_2015$winner_10 <- factor(bes_2015$winner_10, levels=c("Conservative", "Green", "Independent", "Labour", "Liberal Democrat", "Other", "Plaid Cymru", "Scottish National Party", "UKIP"))
  devtools::use_data(bes_2015, overwrite = TRUE)

  
## General Election Data 2017 -----------------------------------------------------------
  library(readxl)
  ge_2017 <- read_xlsx("./data-raw/GE2017.xlsx")
  facs <- c('Country' ,'ConstituencyName', 'Region', 'ConstituencyType', 'Winner17', 'Winner15', 'SeatChange1517')
  ge_2017[,facs] <- lapply(ge_2017[,facs], factor)
  names(ge_2017) <- gsub("([[:lower:]])([[:upper:]])", "\\1_\\2", names(ge_2017))
  names(ge_2017) <- gsub(" ", "_", names(ge_2017))
  names(ge_2017) <- tolower(names(ge_2017))
  names(ge_2017) <- gsub("([[:digit:]])([[:lower:]])", "\\1_\\2", names(ge_2017))
  names(ge_2017) <- gsub("([[:lower:]])([[:digit:]])", "\\1_\\2", names(ge_2017))
  ge_2017$winner_15 <- factor(ge_2017$winner_15, levels=c("Conservative", "Green", "Independent", "Labour", "Liberal Democrat", "Other", "Plaid Cymru", "Scottish National Party", "UKIP"))
  ge_2017$winner_17 <- factor(ge_2017$winner_17, levels=c("Conservative", "Green", "Independent", "Labour", "Liberal Democrat", "Other", "Plaid Cymru", "Scottish National Party"))
  devtools::use_data(ge_2017, overwrite = TRUE)
  
  
## Local Authority Control Data --------------------------------------------

  library(readr)
  library(dplyr)
  library(readxl)
  council_data <- read_csv("~/GitHub/parlitools/data-raw/opencouncildata_councils.csv")
  council_data$type <- NULL
  council_data$id <- NULL
  council_data$model <- NULL
  council_data <- rename(council_data,
                         name = name,
                         majority_party = majority,
                         governing_coalition = coalition,
                         conservative_councillors = con,
                         labour_councillors = lab,
                         lib_dem_councillors = ld,
                         green_councillors = grn,
                         ukip_councillors = ukip,
                         plaid_cymru_councillors = pc,
                         snp_councillors = snp,
                         independent_councillors = ind,
                         vacant_seats = vacant,
                         total_councillors = total,
                         boundary = boundary,
                         notes = notes,
                         url = url,
                         last_update = last)
  
  council_data$total_councillors <- rowSums(council_data[, c("conservative_councillors", "labour_councillors", "lib_dem_councillors", "green_councillors", "ukip_councillors", "snp_councillors", "independent_councillors", "vacant_seats")])
  
  ## Recoding council_data$majority_party into council_data$majority_party_rec
council_data$majority_party <- recode(council_data$majority_party,
               "IND" = "Independent",
               "CON" = "Conservative",
               "NOC" = "No Overall Control",
               "LAB" = "Labour",
               "LD" = "Liberal Democrat",
               "PC" = "Plaid Cymru")
  

  parties <- read_excel("./data-raw/party_colour.xlsx")

  council_data <- left_join(council_data, parties, by=c("majority_party"="party_name"))
  
  rm(parties)
  
  council_data <- rename(council_data, majority_party_id=party_id)
  
  council_data$party_colour <- NULL
  
  council_data$name <- recode(council_data$name,
                              "Copeland (M)" = "Copeland",
                              "Mansfield (M)" = "Mansfield",
                              "Hackney (M)" = "Hackney",
                              "Lewisham (M)" = "Lewisham",
                              "Newham (M)" = "Newham",
                              "Tower Hamlets (M)" = "Tower Hamlets",
                              "Doncaster (M)" = "Doncaster",
                              "Liverpool (M)" = "Liverpool",
                              "Salford (M)" = "Salford",
                              "Bedford (M)" = "Bedford",
                              "Bristol (M)" = "Bristol",
                              "Leicester (M)" = "Leicester",
                              "Middlesbrough (M)" = "Middlesbrough",
                              "Torbay (M)" = "Torbay",
                              "Hinckley & Bosworth" = "Hinckley and Bosworth",
                              "Newark & Sherwood" = "Newark and Sherwood",
                              "Oadby & Wigston" = "Oadby and Wigston",
                              "Tonbridge & Malling" = "Tonbridge and Malling",
                              "Nuneaton & Bedworth" = "Nuneaton and Bedworth",
                              "Basingstoke & Deane" = "Basingstoke and Deane",
                              "Reigate & Banstead" = "Reigate and Banstead",
                              "Weymouth & Portland" = "Weymouth and Portland",
                              "Barking & Dagenham" = "Barking and Dagenham",
                              "Hammersmith & Fulham" = "Hammersmith and Fulham",
                              "Kensington & Chelsea" = "Kensington and Chelsea",
                              "St. Helens" = "St Helens",
                              "Aberdeen City" = "Aberdeen",
                              "Argyll & Bute" = "Argyll and Bute",
                              "Dumfries & Galloway" = "Dumfries and Galloway",
                              "Dundee" = "Dundee",
                              "Edinburgh" = "City of Edinburgh",
                              "Glasgow" = "Glasgow City",
                              "Orkney" = "Orkney Islands",
                              "Perth & Kinross" = "Perth and Kinross",
                              "Shetland" = "Shetland Islands",
                              "Brighton & Hove" = "Brighton and Hove",
                              "Bristol" = "City of Bristol",
                              "Cheshire West & Chester" = "Cheshire West and Chester",
                              "Durham" = "County Durham",
                              "Redcar & Cleveland" = "Redcar and Cleveland",
                              "Telford & Wrekin" = "Telford and Wrekin",
                              "Windsor & Maidenhead" = "Windsor and Maidenhead")
  
  la_codes <- read_csv("./data-raw/la_codes.csv")
  
  council_data <- left_join(council_data, la_codes)
  
  rm(la_codes)
  
  council_data <- council_data[c("la_code", "name", "type", "majority_party",
  "majority_party_id", "governing_coalition",  "total_councillors", "conservative_councillors",
  "labour_councillors", "lib_dem_councillors", "green_councillors", "ukip_councillors",
  "plaid_cymru_councillors", "snp_councillors", "independent_councillors", "vacant_seats",
  "boundary", "notes", "url", "last_update")]
  
  devtools::use_data(council_data, overwrite = TRUE)
  

## Brexit Votes by Constituency --------------------------------------------

  library(readxl)
  leave_votes_west <- read_excel("~/GitHub/parlitools/data-raw/Estimates-of-constituency-level-EU-referendum-result.xlsx")
  leave_votes_west$known_leave_vote <- as.factor(leave_votes_west$known_leave_vote)
  leave_votes_west$party_2016  <- factor(leave_votes_west$party_2016, levels=c("Conservative", "Green", "Independent", "Labour", "Liberal Democrat", "Other", "Plaid Cymru", "Scottish National Party", "UKIP", "DUP", "Sinn Fein", "SDLP", "UUP"))
  devtools::use_data(leave_votes_west, overwrite = TRUE)
  