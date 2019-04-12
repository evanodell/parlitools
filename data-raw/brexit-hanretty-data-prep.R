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

leave_votes_west <- leave_votes_west %>%
  rename(ons_const_id = gss_code,
         constituency_name = constituency)

summary(leave_votes_west)

usethis::use_data(leave_votes_west, overwrite = TRUE)
