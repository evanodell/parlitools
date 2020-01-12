

## British Election Study Data 2015 -----------------------------------------------------------

library(readxl)
bes_2015 <- read_xlsx("./data-raw/BES-2015-General-Election-results-file-v2.21.xlsx")

facs <- c("Country", "ConstituencyName", "Region", "ConstituencyType", 
          "Winner15", "Winner10", "SeatChange1015", "ConPPC", "ConPPCsex",
          "ConPPCrace", "LabPPC", "LabPPCsex", "LabPPCrace", "LDPPC",
          "LDPPCsex", "LDPPCrace", "UKIPPPC", "UKIPPPCsex", "UKIPPPCrace", 
          "SNPPPC", "SNPPPCsex", "SNPPPCrace", "PCPPC", "PCPPCsex", "PCPPCrace",
          "GreenPPC", "GreenPPCsex", "GreenPPCrace")

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
bes_2015$winner_15 <- factor(bes_2015$winner_15, 
                             levels = c("Conservative", "Green", "Independent",
               "Labour", "Liberal Democrat", "Other",
               "Plaid Cymru",
               "Scottish National Party", "UKIP"))

bes_2015$winner_10 <- factor(bes_2015$winner_10,
                             levels = c("Conservative", "Green", "Independent",
               "Labour", "Liberal Democrat", "Other",
               "Plaid Cymru",
               "Scottish National Party", "UKIP"))

bes_2015 <- bes_2015[c(1:78, 264:277)]

usethis::use_data(bes_2015, overwrite = TRUE)

## British Election Study Data 2017 -----------------------------------------------------------

library(readxl)
bes_2017 <- read_xlsx("./data-raw/BES-2017-General-Election-results-file-v1.0.xlsx")

# facs <- c("Country", "ConstituencyName", "Region", "ConstituencyType", 
#           "Winner17", "Winner15", "Winner10", "SeatChange1517",
#           "SeatChange1015", "ConPPC15", "ConPPCsex15", "ConPPCrace15",
#           "LabPPC15", "LabPPCsex15", "LabPPCrace15", "LDPPC15", "LDPPCsex15",
#           "LDPPCrace15", "UKIPPPC15", "UKIPPPCsex15", "UKIPPPCrace15", 
#           "SNPPPC15", "SNPPPCsex15", "SNPPPCrace15", "PCPPC15", "PCPPCsex15",
#           "PCPPCrace15", "GreenPPC15", "GreenPPCsex15", "GreenPPCrace15", 
#           "ConPPC17", "ConPPCsex17", "LabPPC17", "LabPPCsex17", "LDPPC17", 
#           "LDPPCsex17", "UKIPPPC17", "UKIPPPCsex17", "SNPPPC17", "SNPPPCsex17",
#           "PCPPC17", "PCPPCsex17", "GreenPPC17", "GreenPPCsex17")

# bes_2017[, facs] <- lapply(bes_2017[, facs], factor)
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

# bes_2017$winner_15 <- factor(bes_2017$winner_15,
#                              levels = c("Conservative", "Green", "Independent",
#                "Labour", "Liberal Democrat", "Other",
#                "Plaid Cymru", 
#                "Scottish National Party", "UKIP",
#                "Speaker"))
# 
# bes_2017$winner_10 <- factor(bes_2017$winner_10,
#                              levels = c("Conservative", "Green", "Independent", 
#                "Labour", "Liberal Democrat", "Other",
#                "Plaid Cymru", 
#                "Scottish National Party", "UKIP",
#                "Speaker"))

bes_2017 <- bes_2017 %>%
  bind_rows(select(ni_ge_2017, "ons_const_id", "pano", "constituency_name",
                   "constituency_type", "region", "country", "electorate_15",
                   "turnout_15", "winner_15", "majority_15", "electorate_17",
                   "turnout_17", "winner_17", "majority_17"))

bes_2017 <- bes_2017 %>% 
  mutate_at(vars(matches("winner")), factor)


usethis::use_data(bes_2017, overwrite = TRUE)

## HOC library Data 2019 -----------------------------------------------------------

## Candidates

library(stringr)
library(stringi)
library(readr)
library(dplyr)
library(tidyr)

#https://candidates.democracyclub.org.uk/api/docs/csv/#past
candidates <- read_csv("data-raw/candidates-parl.2019-12-12.csv") %>% 
  mutate(ons_const_id = gsub("WMC:", "", post_id)) %>%
  select(-favourite_biscuits, -cancelled_poll, -wikidata_id, -blog_url,
         -instagram_url, -youtube_profile, -gss_code, 
         -mapit_url,  -elected, -email, -twitter_username, -facebook_page_url,
         -party_ppc_page_url, -facebook_personal_url, -homepage_url,
         -wikipedia_url, -linkedin_url, -image_url, -proxy_image_url_template,
         -image_copyright, -image_uploading_user,
         -image_uploading_user_notes,-twitter_user_id, -election_date,
         -election_current, -party_lists_in_use, -party_list_position,
         -old_person_ids, -parlparse_id, -theyworkforyou_url, -party_ec_id,
         -honorific_prefix, -honorific_suffix, -election, -post_id, -id,
         -party_id, -birth_date, -post_label) %>%
  mutate(gender = case_when(gender == "male" ~ "Male",
                            gender == "female" ~ "Female",
                            gender == "transgender female" ~ "Transgender Female",
                            gender == "female, transgender" ~ "Transgender Female",
                            gender == "non-binary"~ "Non-Binary",
                            TRUE ~ gender))

candidates2 <- candidates %>% 
  mutate(party_name = recode(
  party_name,
  "Labour and Co-operative Party" = "Labour",
  "Labour Party" = "Labour",
  "Green Party" = "Green",
  "Liberal Democrats" = "Liberal Democrat",
  "UK Independence Party (UKIP)" = "UKIP",
  "Plaid Cymru - The Party of Wales" = "Plaid Cymru",
  "Conservative and Unionist Party" = "Conservative",
  "Scottish Green Party" = "Green",      
  "Speaker seeking re-election" = "Speaker",  
  "SDLP (Social Democratic & Labour Party)" = "Social Democratic & Labour Party", 
  "Scottish National Party (SNP)"= "Scottish National Party",  
  "Sinn Féin" = "Sinn Fein",
  "Democratic Unionist Party - D.U.P." = "Democratic Unionist Party",             
  "Alliance - Alliance Party of Northern Ireland" = "Alliance")) %>% 
  filter(party_name %in% c("Green",
                           "Liberal Democrat", 
                           "Labour",
                           "UKIP",
                           "Plaid Cymru",
                           "Conservative",
                           "Speaker",                        
                           "Social Democratic & Labour Party",            
                           "Scottish National Party",                      
                           "Sinn Sein",                                          
                           "Democratic Unionist Party",                 
                           "The Brexit Party",                                   
                           "Alliance",
                           "Ulster Unionist Party")) %>%
  pivot_wider(values_from = c(name, gender), names_from = party_name) %>%
  janitor::clean_names()
  
names(candidates2) <- stri_replace_all_regex(
  names(candidates2), 
  c("social_democratic_labour_party", "democratic_unionist_party",
    "ulster_unionist_party", "plaid_cymru", "labour", "liberal_democrat",
    "conservative", "the_brexit_party", "scottish_national_party"), 
  c("sdlp", "dup", "uup", "pc", "lab", "ld", "con", "brexit", "snp"),
  vectorize_all = FALSE  )
  
names(candidates2) <- str_replace_all(names(candidates2),
                                      "name_(.*)$", "\\1_ppc_19")
names(candidates2) <- str_replace_all(names(candidates2),
                                      "gender_(.*)$", "\\1_ppc_sex_19")

# results

# from: https://researchbriefings.parliament.uk/ResearchBriefing/Summary/CBP-8749
bes_2019_full <- read_csv("./data-raw/HoC-GE2019-results-by-constituency.csv") %>%
  select(-declaration_time, -mp_firstname, -mp_gender, -mp_surname,
         -second_party) %>% 
  rename("ons_const_id" = ons_id,
         "winner_19" = "first_party",
         "speaker" = "other_winner",
        "rejected_vote_19" = "invalid_votes",
        "total_vote_19" = "valid_votes",
        "electorate_19" = "electorate",
        "seat_change_1719" = "result",
        "majority_19" = "majority",
        "county" = "county_name",
        "region" = "region_name",
        "country" = "country_name") %>% 
  mutate(turnout_19 = ((total_vote_19 + rejected_vote_19)/electorate_19)*100,
         winner_19 = recode(
           winner_19,
           "Green" =  "Green",
           "LD" = "Liberal Democrat", 
           "Lab" =  "Labour",
           "PC" =  "Plaid Cymru",
           "Con" = "Conservative",
           "Spk" = "Speaker",                        
           "SDLP" = "Social Democratic & Labour Party",            
           "SNP" ="Scottish National Party",                      
           "SF" = "Sinn Fein",                                          
           "DUP" = "Democratic Unionist Party",                 
           "Alliance" = "Alliance",
           "UUP" = "Ulster Unionist Party"))

bes_2019_full <- bes_2019_full %>% 
  rename_at(vars(con:speaker), ~paste0(., "_vote_19"))

bes_2019_full <- bes_2019_full %>%
  mutate_at(list(perc = ~./total_vote_19),
            .vars = vars(con_vote_19:speaker_vote_19)) %>%
  mutate_at(vars(con_vote_19_perc:speaker_vote_19_perc), ~.*100)

names(bes_2019_full) <- str_replace_all(names(bes_2019_full),
                                      "(.*)_vote_19_perc", "\\1_19")

bes_2019_full <- bes_2019_full %>% 
  mutate(seat_change_1719 = ifelse(
    substr(seat_change_1719, nchar(seat_change_1719)-4, 
           nchar(seat_change_1719)) == " hold",
    NA,  seat_change_1719),
    seat_change_1719 = str_replace_all(seat_change_1719, "Lab Coop", "Lab"),
    seat_change_1719 = stri_replace_all_regex(
  seat_change_1719, 
  c("Spk", "Con", "Lab", "LD", "Ind", "SF", "SNP", "SDLP", "DUP"), 
  c("Speaker", "Conservative", "Labour", "Liberal Democrat", "Independent",
    "Sinn Fein", "Scottish National Party", "Social Democratic & Labour Party",
    "Democratic Unionist Party"),
  vectorize_all = FALSE ))

bes_2017 <- parlitools::bes_2017 %>%
  select(pano:ons_const_id, winner_17:electorate_17, 
         leave_hanretty, remain_hanretty)

bes_2019_gb <- bes_2019_full %>% filter(region != "Northern Ireland")

bes_2019_gb <- inner_join(bes_2019_gb, 
                      bes_2017)




ni_ge_2017 <- parlitools::ni_ge_2017

ni_ge_2017 <- ni_ge_2017 %>% select(pano, ons_const_id, electorate_17:con_17)

leave_votes_west <- parlitools::leave_votes_west  %>%
  mutate(leave_hanretty = figure_to_use*100) %>%
  select(ons_const_id, leave_hanretty)

ni_ge_2017 <- ni_ge_2017 %>%
  inner_join(leave_votes_west) %>%
  mutate(remain_hanretty = 100-leave_hanretty) %>%
  rename(total_vote_17 = total_votes_17)

x4 <- bes_2019_full %>%
  inner_join(ni_ge_2017)

bes_2019 <- bind_rows(bes_2019_gb, x4)

bes_2019 <- bes_2019 %>%
  mutate(con_1719 = con_19 - con_17,
         lab_1719 = lab_19 - lab_17,
         ld_1719  = ld_19  - ld_17 ,
         green_1719   = green_19   - green_17  ,
         snp_1719 = snp_19 - snp_17,
         pc_1719  = pc_19  - pc_17,
         uup_1719 = uup_19 - uup_17,
         dup_1719 = dup_19 - dup_17,
         alliance_1719 = alliance_19 - alliance_17,
         sf_1719 = sf_19 - sf_17,
         sdlp_1719 = sdlp_19 - sdlp_17
         )


glimpse(bes_2019)

# bes_2019 <- bes_2019 %>% select(pano, ons_const_id:speaker_19, con_1719:pc_1719,
#                                 winner_17:electorate_17, leave_hanretty,
#                                 remain_hanretty)

bes_2019 <- bes_2019 %>% left_join(candidates2)

bes_2019[bes_2019==0] <- NA

usethis::use_data(bes_2019, overwrite = TRUE)

