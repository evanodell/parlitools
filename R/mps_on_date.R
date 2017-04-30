#' Request information on all MPs who were members of the House of Commons on the date specificed (if only one date is included as a parameter), or on or between the two dates if two are specified. Includes constituency and electoral information.
#'
#' @param date1 The date to return the list of mps from. Defaults to current system date.
#' @param date2 An optional query parameter. If a proper date in "YYYY-MM-DD" format, the function returns a list of all MPs who were members between date2 and date1. Defaults to NULL.
#' @param tidy Fix the variable names in the tibble to remove extra characters, superfluous text and convert variable names to snake_case. Defaults to TRUE.
#'
#' @return A tibble with information on all MPs who were members of the House of Commons on the date specificed (if only date1 is included as a parameter), or on or between the two dates if both date1 and date2 are specified.
#' @export
#'
#' @examples \dontrun{
#'
#' x <- mp_on_date()
#'
#' }


mps_on_date <- function(date1 = Sys.Date(), date2=NULL, tidy = TRUE){
  
#  if(packageVersion("mnis")>"0.2.4") {
    
#    mps <- mnis::mnis_mps_on_date(date1=date1, date2=date2, tidy=tidy)
    
#  } else {
  
    baseurl <- "http://data.parliament.uk/membersdataplatform/services/mnis/members/query/House=Commons|Membership=all|commonsmemberbetween="
    
    if(is.null(date2)==TRUE) {
      date2 <- date1
    } else if (date1 > date2) {
      date3 <- date1
      date1 <- date2
      date2 <- date3
      rm(date3)
    }
    
    query <- paste0(baseurl,date1,"and",date2,"/")
    
    got <- httr::GET(query, httr::accept_json())
    
    if (httr::http_type(got) != "application/json") {
      stop("API did not return json", call. = FALSE)
    }
    
    got <- mnis::tidy_bom(got)
    
    got <- jsonlite::fromJSON(got, flatten = TRUE)
    
    mps <- got$Members$Member
    
    mps <- tibble::as_tibble(mps)
    
    if (tidy == TRUE) {
      
      mps <- mnis::mnis_tidy(mps)
      
      mps
      
    } else {
      
      mps
      
    }
    
#  }
  
  mps$member_from <- gsub("Ynys M\U00C1\U00B4n", "Ynys M\U00F4n", mps$member_from)
  
  message("Downloading constituency data")
  
  suppressMessages(constit <- hansard::constituencies(current = FALSE))
  
  constit <- constit[constit$started_date_value <= date1 & constit$ended_date_value >= date2, ]
  
  suppressMessages(elect <- election_results())

  elect <- subset(elect,!duplicated(elect$constituency_about))
    
  const_elect <- left_join(constit, elect, by = c("about"= "constituency_about")) #Join
  
  df <- dplyr::left_join(mps, const_elect, by = c("member_from"= "label_value"))
  
  df
  
}


