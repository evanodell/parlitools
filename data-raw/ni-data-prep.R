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
         other_vote_17 = select(., `CIST Alliance`, Independent,
                                `Independent (Lady Hermon)`, `PBP Alliance`,
                                TUV, WP) %>%  rowSums(na.rm = TRUE)) %>%
  rename(alliance_vote_17 = Alliance,
         dup_vote_17 = DUP,
         green_vote_17 = `Green Party`,
         sf_vote_17 = `Sinn Féin`,
         sdlp_vote_17 = `SDLP`,
         uup_vote_17 = `UUP`,
         con_vote_17 = `Conservative`) %>%
  select(-`CIST Alliance`, -Independent,
         -`Independent (Lady Hermon)`, -`PBP Alliance`,
         -TUV, -WP)

ge_2017 

check_vector <- rowSums(ge_2017[4:9], na.rm = TRUE) + ge_2017$other_vote_17

admin_17$total_votes_17 == check_vector

all(ge_2017$total_votes_17 == check_vector)

ge_2017 <- ge_2017 %>% left_join(admin_17 %>% select(-total_votes_17)) %>% left_join(ge_2017_winner)

ge_2017 <- ge_2017 %>%
  mutate(alliance_17 = (alliance_vote_17/total_votes_17)*100,
         dup_17 = (dup_vote_17/total_votes_17)*100,
         green_17 = (green_vote_17/total_votes_17)*100,
         sf_17 = (sf_vote_17/total_votes_17)*100,
         sdlp_17 = (sdlp_vote_17/total_votes_17)*100,
         uup_17 = (uup_vote_17/total_votes_17)*100,
         con_17 = (con_vote_17/total_votes_17)*100,
         other_17 = (other_vote_17/total_votes_17)*100,
         ukip_17 = NA,
         turnout_17 = (total_votes_17/electorate_17)*100)

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
                                Independent,
                                `People Before Profit Alliance`,
                                `Traditional Unionist Voice`,
                                `Workers Party`) %>% rowSums(na.rm = TRUE)) %>%
  rename(alliance_vote_15 = Alliance,
         dup_vote_15 = `Democratic Unionist Party`,
         green_vote_15 = Green,
         sf_vote_15 = `Sinn Fein`,
         sdlp_vote_15 = `Social Democratic and Labour Party`,
         uup_vote_15 = `Ulster Unionist Party`,
         ukip_vote_15 = `UK Independence Party`,
         con_vote_15 = `Conservative`) %>% 
  select(-`Cannabis is Safer than Alcohol Party`,
         -`People Before Profit Alliance`, -`Traditional Unionist Voice`,
         -Independent, -`Workers Party`)


results_15 <- results_15 %>% left_join(results_15_winner) %>% left_join(admin_15)

results_15 <- results_15 %>% 
  mutate(alliance_15 = (alliance_vote_15/total_votes_15)*100,
         dup_15 = (dup_vote_15/total_votes_15)*100,
         green_15 = (green_vote_15/total_votes_15)*100,
         sf_15 = (sf_vote_15/total_votes_15)*100,
         sdlp_15 = (sdlp_vote_15/total_votes_15)*100,
         uup_15 = (uup_vote_15/total_votes_15)*100,
         con_15 = (con_vote_15/total_votes_15)*100,
         turnout_15 = (total_votes_15/electorate_15)*100)

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
         con_1517 = con_17 - con_15,
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
                                    majority_15, majority_vote_15,
                                    "alliance_vote_15", "dup_vote_15", 
                                    "green_vote_15", sf_vote_15, "sdlp_vote_15",
                                    "ukip_vote_15", "uup_vote_15", con_vote_15,
                                    "other_vote_15", "alliance_15", "dup_15",
                                    "green_15", "sf_15", "sdlp_15", "uup_15", 
                                    con_15, electorate_17, total_votes_17,
                                    turnout_17, winner_17, majority_17,
                                    majority_vote_17, everything()) %>%
  rename(ons_const_id = ons_code, 
         constituency_name = constituency)

glimpse(ni_results)

ni_ge_2017 <- ni_results %>% left_join(leave_votes_west)

ni_ge_2017 <- ni_ge_2017 %>%
  mutate(majority_15 = majority_15 * 100,
         majority_17 = majority_17 *100)

usethis::use_data(ni_ge_2017, overwrite = TRUE)
## Still need to write up docs for this