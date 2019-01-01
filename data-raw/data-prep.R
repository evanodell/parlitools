
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
local_hex_map$la_name <- gsub("Rhondda Cynon Taf", "Rhondda Cynon Taff",
                              local_hex_map$la_name)
local_hex_map$la_name <- gsub("Kingston upon Hull, City of",
                              "Kingston upon Hull", local_hex_map$la_name)
local_hex_map$la_name <- gsub("Shepway",
                              "Folkestone and Hythe", local_hex_map$la_name)
local_hex_map$la_name <- gsub("Aberdeen City",
                              "Aberdeen", local_hex_map$la_name)
local_hex_map$la_name <- gsub("Dundee City",
                              "Dundee", local_hex_map$la_name)

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
# https://secondreading.uk/brexit/brexit-votes-by-constituency/
# http://www.bbc.co.uk/news/uk-northern-ireland-36616830

library(readxl)
leave_votes_west <- read_excel("~/GitHub/parlitools/data-raw/Estimates-of-constituency-level-EU-referendum-result.xlsx")
leave_votes_west$known_leave_vote <- as.factor(leave_votes_west$known_leave_vote)

leave_votes_west$party_2016 <- factor(leave_votes_west$party_2016, levels = c("Conservative", "Green", "Independent", "Labour", "Liberal Democrat", "Other", "Plaid Cymru", "Scottish National Party", "UKIP", "DUP", "Sinn Fein", "SDLP", "UUP"))

leave_votes_west$combined_leave_vote <- ifelse(leave_votes_west$known_leave_vote == "No", leave_votes_west$ch_leave_vote, leave_votes_west$known_leave_vote_perc)

leave_votes_west$combined_leave_vote <- as.numeric(leave_votes_west$combined_leave_vote)

leave_votes_west$known_leave_vote_perc <- as.numeric(leave_votes_west$known_leave_vote_perc)

leave_votes_west$difference_estimate_known <- as.numeric(leave_votes_west$difference_estimate_known)

leave_votes_west$ch_leave_vote <- as.numeric(leave_votes_west$ch_leave_vote)

leave_votes_west <- leave_votes_west[c("gss_code", "constituency", "party_2016", "known_leave_vote", "ch_leave_vote", "known_leave_vote_perc", "combined_leave_vote", "difference_estimate_known")]

usethis::use_data(leave_votes_west, overwrite = TRUE)
