

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

bes_2017 <- bes_2017 %>%
  bind_rows(select(ni_ge_2017, "ons_const_id", "pano", "constituency_name",
                   "constituency_type", "region", "country", "electorate_15",
                   "turnout_15", "winner_15", "majority_15", "electorate_17",
                   "turnout_17", "winner_17", "majority_17"))

bes_2017 <- bes_2017 %>% 
  mutate_at(vars(matches("winner")), factor)


usethis::use_data(bes_2017, overwrite = TRUE)
