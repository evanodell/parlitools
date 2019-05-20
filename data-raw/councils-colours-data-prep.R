
# Party Colours -----------------------------------------------------------

library(readxl)
party_colour <- read_excel("./data-raw/party_colour.xlsx")
party_colour$party_name <- as.factor(party_colour$party_name)
party_colour$party_id <- as.character(party_colour$party_id)
usethis::use_data(party_colour, overwrite = TRUE)

# Datasets ---------------------

# ## Local Authority Codes --------------------------------------------
la_codes <- read_csv("data-raw/la_codes.csv")

usethis::use_data(la_codes, overwrite = TRUE)