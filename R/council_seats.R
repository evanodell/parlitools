

#' Council Seats
#' 
#' Downloads data from 
#' <[http://opencouncildata.co.uk/](http://opencouncildata.co.uk/)>, with the
#' composition of each local council in Great Britain.
#'
#' @param councillors If `TRUE`, downloads details on each individual 
#' councillor. Defaults to `FALSE` and downloads summary data for each council.
#'
#' @return A tibble with council seat distribution
#' @export

council_seats <- function(councillors = FALSE) {
  
  if (councillors == TRUE) {
    councillor_data <- readr::read_csv("http://opencouncildata.co.uk/csv2.php",
                                       col_types = readr::cols(
                                         .default = "c"
                                       ))
    council_data <- readr::read_csv("http://opencouncildata.co.uk/csv1.php",
                                    col_types = readr::cols(
                                      .default = "c"
                                    ))
    
    council_data <- council_data[c("id", "ons code", "name", "type")]
    
    
    df <- dplyr::left_join(councillor_data, council_data,
                           by = c("councilID" = "id"))
  } else {

council_data <- readr::read_csv("http://opencouncildata.co.uk/csv1.php",
                                col_types = readr::cols(
                                  .default = "c"
                                ))
council_data$type <- NULL
council_data$id <- NULL
council_data$model <- NULL
council_data <- dplyr::rename(council_data,
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
                       last_update = last)

names(council_data) <- snakecase::to_snake_case(names(council_data))

council_data$total_councillors <- rowSums(
  council_data[, c("conservative_councillors",
                   "labour_councillors",
                   "lib_dem_councillors",
                   "green_councillors",
                   "ukip_councillors",
                   "snp_councillors",
                   "independent_councillors", 
                   "vacant_seats")])

## Recoding council_data$majority_party into council_data$majority_party_rec
council_data$majority_party <- dplyr::recode(council_data$majority_party,
                                      "IND" = "Independent",
                                      "CON" = "Conservative",
                                      "NOC" = "No Overall Control",
                                      "LAB" = "Labour",
                                      "LD" = "Liberal Democrat",
                                      "PC" = "Plaid Cymru")

council_data$name <- dplyr::recode(
  council_data$name,
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

la_codes <- parlitools::la_codes

council_data <- dplyr::left_join(council_data, la_codes)

rm(la_codes)

df <- council_data[c("la_code", "name", "type", "majority_party",
                               "governing_coalition",
                               "total_councillors", "conservative_councillors",
                               "labour_councillors", "lib_dem_councillors",
                               "green_councillors", "ukip_councillors",
                               "plaid_cymru_councillors", "snp_councillors",
                               "independent_councillors", "vacant_seats",
                               "boundary", "url", "last_update")]

}
df

}




