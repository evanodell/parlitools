
# Party Colours -----------------------------------------------------------

library(readxl)
party_colour <- read_excel("./data-raw/party_colour.xlsx")
party_colour$party_name <- as.factor(party_colour$party_name)
party_colour$party_id <- as.character(party_colour$party_id)
usethis::use_data(party_colour, overwrite = TRUE)

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

# Datasets ---------------------

# ## Local Authority Codes --------------------------------------------
la_codes <- read_csv("data-raw/la_codes.csv")

usethis::use_data(la_codes, overwrite = TRUE)

## British Election Study Data 2015 -----------------------------------------------------------

library(readxl)
bes_2015 <- read_xlsx("./data-raw/BES-2015-General-Election-results-file-v2.21.xlsx")
facs <- c("Country", "ConstituencyName", "Region", "ConstituencyType", "Winner15", "Winner10", "SeatChange1015", "ConPPC", "ConPPCsex", "ConPPCrace", "LabPPC", "LabPPCsex", "LabPPCrace", "LDPPC", "LDPPCsex", "LDPPCrace", "UKIPPPC", "UKIPPPCsex", "UKIPPPCrace", "SNPPPC", "SNPPPCsex", "SNPPPCrace", "PCPPC", "PCPPCsex", "PCPPCrace", "GreenPPC", "GreenPPCsex", "GreenPPCrace")
bes_2015[, facs] <- lapply(bes_2015[, facs], factor)
names(bes_2015) <- gsub("([[:lower:]])([[:upper:]])", "\\1_\\2", names(bes_2015))
names(bes_2015) <- gsub(" ", "_", names(bes_2015))
names(bes_2015) <- tolower(names(bes_2015))
names(bes_2015) <- gsub("([[:digit:]])([[:lower:]])", "\\1_\\2", names(bes_2015))
names(bes_2015) <- gsub("([[:lower:]])([[:digit:]])", "\\1_\\2", names(bes_2015))
names(bes_2015) <- gsub("ppc", "_ppc_", names(bes_2015))
names(bes_2015) <- gsub("vote", "_vote_", names(bes_2015))
names(bes_2015) <- gsub("__", "_", names(bes_2015))
names(bes_2015)[names(bes_2015) == "onsconst_id"] <- "ons_const_id"
nums <- c("snplong_spend_percent", "snpshort_spend_percent", "pclong_spend_percent", "pcshort_spend_percent")
bes_2015[, nums] <- lapply(bes_2015[, nums], as.numeric)
bes_2015$winner_15 <- factor(bes_2015$winner_15, levels = c("Conservative", "Green", "Independent", "Labour", "Liberal Democrat", "Other", "Plaid Cymru", "Scottish National Party", "UKIP"))
bes_2015$winner_10 <- factor(bes_2015$winner_10, levels = c("Conservative", "Green", "Independent", "Labour", "Liberal Democrat", "Other", "Plaid Cymru", "Scottish National Party", "UKIP"))

bes_2015 <- bes_2015[c(1:78, 264:277)]

usethis::use_data(bes_2015, overwrite = TRUE)

## British Election Study Data 2017 -----------------------------------------------------------

library(readxl)
bes_2017 <- read_xlsx("./data-raw/BES-2017-General-Election-results-file-v1.0.xlsx")
facs <- c("Country", "ConstituencyName", "Region", "ConstituencyType", "Winner17", "Winner15", "Winner10", "SeatChange1517", "SeatChange1015", "ConPPC15", "ConPPCsex15", "ConPPCrace15", "LabPPC15", "LabPPCsex15", "LabPPCrace15", "LDPPC15", "LDPPCsex15", "LDPPCrace15", "UKIPPPC15", "UKIPPPCsex15", "UKIPPPCrace15", "SNPPPC15", "SNPPPCsex15", "SNPPPCrace15", "PCPPC15", "PCPPCsex15", "PCPPCrace15", "GreenPPC15", "GreenPPCsex15", "GreenPPCrace15", "ConPPC17", "ConPPCsex17", "LabPPC17", "LabPPCsex17", "LDPPC17", "LDPPCsex17", "UKIPPPC17", "UKIPPPCsex17", "SNPPPC17", "SNPPPCsex17", "PCPPC17", "PCPPCsex17", "GreenPPC17", "GreenPPCsex17")
bes_2017[, facs] <- lapply(bes_2017[, facs], factor)
names(bes_2017) <- gsub("([[:lower:]])([[:upper:]])", "\\1_\\2", names(bes_2017))
names(bes_2017) <- gsub(" ", "_", names(bes_2017))
names(bes_2017) <- tolower(names(bes_2017))
names(bes_2017) <- gsub("([[:digit:]])([[:lower:]])", "\\1_\\2", names(bes_2017))
names(bes_2017) <- gsub("([[:lower:]])([[:digit:]])", "\\1_\\2", names(bes_2017))
names(bes_2017) <- gsub("ppc", "_ppc_", names(bes_2017))
names(bes_2017) <- gsub("vote", "_vote_", names(bes_2017))
names(bes_2017) <- gsub("__", "_", names(bes_2017))
names(bes_2017)[names(bes_2017) == "onsconst_id"] <- "ons_const_id"

census_11 <- bes_2017[c(1:6, 124:308)]
names(census_11) <- gsub("c_11_", "", names(census_11))
usethis::use_data(census_11, overwrite = TRUE)

bes_2017 <- bes_2017[c(0:123)]

bes_2017$winner_15 <- factor(bes_2017$winner_15, levels = c("Conservative", "Green", "Independent", "Labour", "Liberal Democrat", "Other", "Plaid Cymru", "Scottish National Party", "UKIP"))
bes_2017$winner_10 <- factor(bes_2017$winner_10, levels = c("Conservative", "Green", "Independent", "Labour", "Liberal Democrat", "Other", "Plaid Cymru", "Scottish National Party", "UKIP"))
usethis::use_data(bes_2017, overwrite = TRUE)





## Brexit Votes by Constituency --------------------------------------------
# https://medium.com/@chrishanretty/final-estimates-of-the-leave-vote-or-areal-interpolation-and-the-uks-referendum-on-eu-membership-5490b6cab878
# https://docs.google.com/spreadsheets/d/1b71SDKPFbk-ktmUTXmDpUP5PT299qq24orEA0_TOpmw/edit#gid=579044181
# http://www.bbc.co.uk/news/uk-northern-ireland-36616830

library(readxl)
library(dplyr)
library(snakecase)
leave_votes_west1 <- read_excel("data-raw/Estimates-of-constituency-level-EU-referendum-result.xlsx")

leave_votes_west1 <- leave_votes_west1 %>% select(gss_code, constituency, party_2016)

leave_votes_west1$party_2016 <- factor(leave_votes_west1$party_2016, 
                                      levels = c("Conservative", "Green",
                                                 "Independent", "Labour",
                                                 "Liberal Democrat", "Other",
                                                 "Plaid Cymru",
                                                 "Scottish National Party",
                                                 "UKIP", "DUP", "Sinn Fein",
                                                 "SDLP", "UUP"))

leave_votes_west2 <- read_excel("data-raw/Final estimates of the Leave vote share in the EU referendum.xlsx", 
                                range = "A1:F633")

names(leave_votes_west2) <- to_snake_case(names(leave_votes_west2))

leave_votes_west2 <- leave_votes_west2 %>%
  rename(gss_code = pcon_11_cd, 
         constituency = constituency_name)

leave_votes_west <- left_join(leave_votes_west1, leave_votes_west2)

leave_votes_west$known_leave_vote <- ifelse(
  !is.na(leave_votes_west$known_leave_vote_share), "Yes", "No")

leave_ni <- read_excel("data-raw/brexit-ni-constituencies.xlsx")

leave_votes_west <- bind_rows(leave_votes_west, leave_ni)

leave_votes_west <- leave_votes_west %>%
  rename(ch_leave_vote = estimated_leave_vote_share,
         known_leave_vote_perc = known_leave_vote_share)

leave_votes_west$figure_to_use <- if_else(leave_votes_west$figure_to_use > 1, 
                                          leave_votes_west$figure_to_use/100,
                                          leave_votes_west$figure_to_use)


leave_votes_west$how_do_we_know <- if_else(substr(leave_votes_west$gss_code, start = 1, stop = 1) == "N", 
                                          "BBC Northern Ireland",
                                          leave_votes_west$how_do_we_know)

leave_votes_west <- leave_votes_west %>% rename(ons_const_id = gss_code)

summary(leave_votes_west)

usethis::use_data(leave_votes_west, overwrite = TRUE)





# NI Results --------------------------------------------------------------

library(readxl)
library(dplyr)
library(stringr)
library(tidyr)
library(snakecase)

ge_2017 <- read_excel("data-raw/2017-UKPGE-Electoral-Data.xls", 
                                         sheet = "Results", skip = 1) 

admin_17 <- read_excel("data-raw/2017-UKPGE-Electoral-Data.xls", 
                      sheet = "Administrative data", skip = 2) %>%
  select(`ONS Code`, Electorate)

names(ge_2017) <- to_snake_case(names(ge_2017))

names(admin_17) <- to_snake_case(names(admin_17))

ge_2017$party_identifer <- if_else(ge_2017$surname == "HERMON",
                                     "Independent (Lady Hermon)",
                                     ge_2017$party_identifer)

ge_2017 <- ge_2017 %>% filter(str_detect(ons_code, "N")) %>%
  select(ons_code, pano, constituency, party_identifer, valid_votes) %>% 
  spread(party_identifer, valid_votes) %>%
  mutate(total_votes = select(., Alliance:WP) %>% rowSums(na.rm = TRUE),
         other_17 = select(., `CIST Alliance`, Conservative, Independent,
                           `Independent (Lady Hermon)`, `PBP Alliance`,
                           TUV, WP) %>%
           rowSums(na.rm = TRUE)) %>%
  
  rename(alliance_17 = Alliance,
         dup_17 = DUP,
         green_17 = `Green Party`,
         sf_17 = `Sinn Féin`,
         sdlp_17 = `SDLP`,
         uup_17 = `UUP`) %>%
  select(ons_code, pano, constituency, alliance_17, dup_17, green_17,
         sdlp_17, sf_17, uup_17, total_votes, other_17)

ge_2017 

check_vector <- rowSums(ge_2017[4:9], na.rm = TRUE) + ge_2017$other_17

all(ge_2017$total_votes == check_vector)

ge_2017 <- ge_2017 %>% left_join(admin_17)

