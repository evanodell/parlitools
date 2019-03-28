
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
library(readr)

## 2017
ge_2017 <- read_excel("data-raw/2017-UKPGE-Electoral-Data.xls", 
                                         sheet = "Results", skip = 1) 

admin_17 <- read_excel("data-raw/2017-UKPGE-Electoral-Data.xls", 
                      sheet = "Administrative data", skip = 2) 
names(ge_2017) <- to_snake_case(names(ge_2017))

names(admin_17) <- to_snake_case(names(admin_17))

admin_17 <- admin_17 %>% 
  rename(total_votes_17 = total_number_of_valid_votes_counted,
         electorate_17 = electorate) %>% 
  select(ons_code, electorate_17, total_votes_17) %>%
  filter(str_detect(ons_code, "N")) 

ge_2017$party_identifer <- if_else(ge_2017$surname == "HERMON",
                                     "Independent (Lady Hermon)",
                                     ge_2017$party_identifer)

ge_2017_winner <- ge_2017 %>%
  filter(str_detect(ons_code, "N")) %>% 
  group_by(constituency) %>% top_n(1) %>%
  left_join(admin_17) %>%
  mutate(votes_perc = valid_votes/total_votes_17)


ge_2017_second <- ge_2017 %>%
  filter(str_detect(ons_code, "N")) %>% 
  arrange(constituency, -valid_votes) %>%
  group_by(constituency) %>%
  slice(2, valid_votes) %>% 
  select(ons_code, pano, constituency, valid_votes) %>% 
  rename(valid_votes2 = valid_votes) %>%
  left_join(admin_17)  %>%
  mutate(votes_perc2 = valid_votes2/total_votes_17)

ge_2017_winner <- ge_2017_winner %>% left_join(ge_2017_second) %>%
  mutate(majority_vote_17 = valid_votes - valid_votes2,
         majority_17 = votes_perc - votes_perc2) %>%
  select(-surname, -first_name, -valid_votes, -valid_votes2) %>%
  rename(winner_17 = party) %>%
  select(ons_code, pano, constituency, winner_17, majority_17, majority_vote_17) 

ge_2017 <- ge_2017 %>% filter(str_detect(ons_code, "N")) %>%
  select(ons_code, pano, constituency, party_identifer, valid_votes) %>% 
  spread(party_identifer, valid_votes) %>%
  mutate(total_votes_17 = select(., Alliance:WP) %>% rowSums(na.rm = TRUE),
         other_vote_17 = select(., `CIST Alliance`, Conservative, Independent,
                           `Independent (Lady Hermon)`, `PBP Alliance`,
                           TUV, WP) %>%  rowSums(na.rm = TRUE)) %>%
  rename(alliance_vote_17 = Alliance,
         dup_vote_17 = DUP,
         green_vote_17 = `Green Party`,
         sf_vote_17 = `Sinn Féin`,
         sdlp_vote_17 = `SDLP`,
         uup_vote_17 = `UUP`) %>%
  select(-`CIST Alliance`, -Conservative, -Independent,
         -`Independent (Lady Hermon)`, -`PBP Alliance`,
         -TUV, -WP)

ge_2017 

check_vector <- rowSums(ge_2017[4:9], na.rm = TRUE) + ge_2017$other_vote_17

admin_17$total_votes_17 == check_vector

all(ge_2017$total_votes_17 == check_vector)

ge_2017 <- ge_2017 %>% left_join(admin_17 %>% select(-total_votes_17)) %>% left_join(ge_2017_winner)

ge_2017 <- ge_2017 %>%
  mutate(alliance_17 = alliance_vote_17/total_votes_17,
         dup_17 = dup_vote_17/total_votes_17,
         green_17 = green_vote_17/total_votes_17,
         sf_17 = sf_vote_17/total_votes_17,
         sdlp_17 = sdlp_vote_17/total_votes_17,
         uup_17 = uup_vote_17/total_votes_17,
         other_17 = other_vote_17/total_votes_17,
         ukip_17 = NA,
         turnout_17 = total_votes_17/electorate_17)

ge_2017

glimpse(ge_2017)


## 2015
results_15 <- read_csv("data-raw/2015-UK-general-election-data-results-WEB/RESULTS.csv") %>%
  select(-X9, -X11)

admin_15 <- read_csv("data-raw/2015-UK-general-election-data-results-WEB/CONSTITUENCY.csv") %>%
  select(-X7)

names(results_15) <- to_snake_case(names(results_15))

names(admin_15) <- to_snake_case(names(admin_15))

admin_15 <- admin_15 %>% 
  rename(electorate_15 = electorate,
         ons_code = constituency_id,
         constituency = constituency_name,
         total_votes_15 = valid_votes)

results_15 <- results_15 %>%
  rename(party_identifier = party_name_identifier,
         valid_votes = votes,
         ons_code = constituency_id,
         constituency = constituency_name)

results_15_winner <- results_15 %>%
  filter(str_detect(ons_code, "N")) %>% 
  group_by(constituency) %>%
  top_n(1, valid_votes) %>% 
  select(ons_code, pano, constituency, party_identifier, valid_votes) %>% 
  left_join(admin_15) %>%
  mutate(votes_perc = valid_votes/total_votes_15)

results_15_second <- results_15 %>%
  filter(str_detect(ons_code, "N")) %>% 
  arrange(constituency, -valid_votes) %>%
  group_by(constituency) %>%
  slice(2, valid_votes) %>% 
  select(ons_code, pano, constituency, valid_votes) %>% 
  rename(valid_votes2 = valid_votes)  %>% 
  left_join(admin_15) %>%
  mutate(votes_perc2 = valid_votes2/total_votes_15)

results_15_winner <- results_15_winner %>% left_join(results_15_second) %>%
  mutate(majority_vote_15 = valid_votes - valid_votes2,
         majority_15 = votes_perc - votes_perc2) %>%
  rename(winner_15 = party_identifier) %>%
  select(ons_code, pano, constituency, winner_15, majority_15, majority_vote_15) 
  

results_15 <- results_15 %>% filter(str_detect(ons_code, "N")) %>%
  select(ons_code, pano, constituency,
         party_identifier, valid_votes) %>% 
  spread(party_identifier, valid_votes) %>%
  mutate(total_votes_15 = select(., Alliance:`Workers Party`) %>% rowSums(na.rm = TRUE),
         other_vote_15 = select(., `Cannabis is Safer than Alcohol Party`,
                                Conservative, Independent,
                                `People Before Profit Alliance`,
                                `Traditional Unionist Voice`,
                                `Workers Party`) %>% rowSums(na.rm = TRUE)) %>%
  rename(alliance_vote_15 = Alliance,
         dup_vote_15 = `Democratic Unionist Party`,
         green_vote_15 = Green,
         sf_vote_15 = `Sinn Fein`,
         sdlp_vote_15 = `Social Democratic and Labour Party`,
         uup_vote_15 = `Ulster Unionist Party`,
         ukip_vote_15 = `UK Independence Party`) %>% 
  select(-`Cannabis is Safer than Alcohol Party`, -Conservative, 
         -`People Before Profit Alliance`, -`Traditional Unionist Voice`,
         -Independent, -`Workers Party`)


results_15 <- results_15 %>% left_join(results_15_winner) %>% left_join(admin_15)

results_15 <- results_15 %>% 
  mutate(alliance_15 = alliance_vote_15/total_votes_15,
         dup_15 = dup_vote_15/total_votes_15,
         green_15 = green_vote_15/total_votes_15,
         sf_15 = sf_vote_15/total_votes_15,
         sdlp_15 = sdlp_vote_15/total_votes_15,
         uup_15 = uup_vote_15/total_votes_15,
         turnout_15 = total_votes_15/electorate_15)

glimpse(results_15)

ni_results <- results_15 %>% left_join(ge_2017)

glimpse(ni_results)


ni_results <- ni_results %>% 
  mutate(alliance_1517 = alliance_17 - alliance_15,
         dup_1517 = dup_17 - dup_15,
         green_1517 = green_17 - green_15,
         sf_1517 = sf_17 - sf_15,
         sdlp_1517 = sdlp_17 - sdlp_15,
         uup_1517 = uup_17 - uup_15,
        winner_17 = recode(
          winner_17,
          "Democratic Unionist Party - D.U.P." = "Democratic Unionist Party",
          "Sinn Féin" = "Sinn Fein"),
        winner_15 = recode(
          winner_15,
          "Social Democratic and Labour Party" = "Social Democratic & Labour Party"),
        )


ni_results$seat_change_1517 <- NA

ni_results$seat_change_1517 <- if_else(
  ni_results$winner_15 == ni_results$winner_17,
  "",
  paste(ni_results$winner_17, "gain from", ni_results$winner_15) 
  )

ni_results$seat_change_1517[ni_results$seat_change_1517==""] <- NA

ni_results$seat_change_1517



ni_results <- ni_results %>% select(ons_code, pano, constituency,
                                    constituency_type, region_id, county,
                                    region, country, electorate_15, 
                                    total_votes_15, turnout_15, winner_15,
                                    majority_15, majority_vote_15, "alliance_vote_15", 
                                    "dup_vote_15", "green_vote_15", sf_vote_15,
                                    "sdlp_vote_15", "ukip_vote_15", 
                                    "uup_vote_15", "other_vote_15", 
                                    "alliance_15", "dup_15", "green_15", 
                                    "sf_15", "sdlp_15", "uup_15", 
                                    electorate_17, 
                                    total_votes_17, turnout_17, winner_17,
                                    majority_17, majority_vote_17,
                                    everything()) %>%
  rename(ons_const_id = ons_code)

glimpse(ni_results)

usethis::use_data(ni_results)
## Still need to write up docs for this
