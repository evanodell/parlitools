# House of Commons Library Summary Data 1950-2010 --------------------------

library(readxl)
library(janitor)
library(dplyr)
library(stringr)

path <- "data-raw/hocl-data/1918-2017election_results_by_pcon.xlsx"
sheets <- excel_sheets(path)

election_list <- lapply(excel_sheets(path), read_excel, path = path, skip = 2)
names(election_list) <- sheets

election_list <- election_list[10:28]

election_list <- lapply(election_list, remove_empty, which = "cols")

for (i in seq_along(election_list)) {
  names(election_list[[i]]) <- paste0(election_list[[i]][1,],
                                      names(election_list[[i]]))
  
  election_list[[i]] <- clean_names(election_list[[i]])
  
  #removing vote shares
  election_list[[i]]  <- election_list[[i]]  %>% select(-contains("share"))
  
  #removing first row
  election_list[[i]] = election_list[[i]][-1,]
  
  names(election_list[[i]]) <- str_remove_all(
    names(election_list[[i]]), "_[0-9]{1,2}")
  
  names(election_list[[i]]) <- str_replace_all(
    names(election_list[[i]]), "conservative_party", "conservative")
  
  names(election_list[[i]]) <- str_replace_all(
    names(election_list[[i]]), "national_liberal_national_liberal_", "national_liberal_")
  
  names(election_list[[i]]) <- str_replace_all(
    names(election_list[[i]]), "n_aid", "id")
  
  election_list[[i]]$election <- names(election_list)[i]
  
  election_list[[i]] <- lapply( election_list[[i]], as.character)
}


library(tidyr)
library(snakecase)

x <- bind_rows(election_list)

x <- x %>% select(-na) %>% 
  filter(!is.na(id)) %>% 
  mutate(seats = 1)

x <- x %>% 
  pivot_longer(cols = starts_with("vote"),
               names_to = "party", values_to = "votes")

x <- x %>% filter(!is.na(votes)) %>%
  mutate(party = str_remove_all(party, "votes_"),
         party = str_replace_all(party, "_", " "),
         party = to_title_case(party))


no_single_files <- x %>% filter(election <= 2014)


# HOC Library 2015,2017,2019 Specific Data --------------------------
library(readr)

results <- list()

results[[1]] <- read_csv(
  "data-raw/hocl-data/hoc-ge2015-results-full.csv"
  )

results[[1]] <- results[[1]] %>% 
  mutate(election = "2015")


results[[2]] <- read_csv(
  "data-raw/hocl-data/HoC-GE2017-results-by-candidate.csv"
  )

results[[2]] <- results[[2]] %>% 
  mutate(election = "2017")


results[[3]] <- read_csv(
  "data-raw/hocl-data/HoC-GE2019-results-by-candidate.csv"
  )

results[[3]] <- results[[3]] %>% 
  mutate(election = "2019")

results_df <- bind_rows(results)

x2 <- x %>% 
  select(id, electorate, election) %>% 
  distinct_all()


results_df <- results_df %>% left_join(x2, by = c("ons_id" = "id",
                                                  "election" = "election"))

