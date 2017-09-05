
#' MPs on or between two dates 
#' 
#' Retrieve information on all MPs who were members of the House of Commons on a date or between two dates. 
#' 
#' Returns information on all MPs who were members of the House of Commons on the date specificed (if only one date is included as a parameter), or on or between the two dates if both are specified. Includes constituency and electoral information if the date is 2010-05-06 or later, or if the date range is entirely between 2010-05-06 and the present day. This function is identical to the \code{\link[mnis]{mnis_mps_on_date}} function from \code{mnis}, except it includes consituency data from 2010-05-06 onwards.
#'
#' @param date1 The date to return the list of MPs from. Accepts character values in \code{'YYYY-MM-DD'} format, and objects of class \code{Date}, \code{POSIXt}, \code{POSIXct}, \code{POSIXlt} or anything else than can be coerced to a date with \code{as.Date()}. Defaults to current system date. 
#' @param date2 An optional query parameter. Accepts character values in \code{'YYYY-MM-DD'} format, and objects of class \code{Date}, \code{POSIXt}, \code{POSIXct}, \code{POSIXlt} or anything else than can be coerced to a date with \code{as.Date()}. If a proper date, the function returns a list of all MPs who were members between \code{date2} and \code{date1}. Defaults to \code{NULL}.
#' @param tidy If \code{TRUE}, fixes the variable names in the tibble to remove special characters and superfluous text, and converts the variable names to a consistent style. Defaults to \code{TRUE}.
#' @param tidy_style The style to convert variable names to, if \code{tidy=TRUE}. Accepts one of \code{'snake_case'}, \code{'camelCase'} and \code{'period.case'}. Defaults to \code{'snake_case'}.
#'
#' @return A tibble with information on all MPs who were members of the House of Commons on the date specificed (if only \code{date1} is included as a parameter), or on or between the two dates if both \code{date1} and \code{date2} are specified.
#' @export
#'
#' @examples \dontrun{
#' x <- mps_on_date(date1="2017-04-19", date2="2010-05-04")
#' }


mps_on_date <- function(date1 = Sys.Date(), date2=NULL, tidy = TRUE, tidy_style="snake_case"){
  
  date1 <- as.Date(date1)
  
  if(is.null(date2)==FALSE) {
    
    date2 <- as.Date(date2)
    
  }
  
  if(is.null(date2)==TRUE) {
    
    date2 <- date1
    
  } else if (date1 > date2) {
    
    date3 <- date1
    
    date1 <- date2
    
    date2 <- date3
    
    rm(date3)
    
  }
  
  mps <- mnis::mnis_mps_on_date(date1 = date1, date2=date2, tidy = tidy, tidy_style=tidy_style)
    
  if(date1 >= "2010-05-06"){
    
    mps <- parlitools_tidy(mps, tidy_style = "snake_case")
    
    message("Downloading constituency data")
    
    suppressMessages(constit <- hansard::constituencies(current = FALSE))
    
    constit$ended_date_value[is.na(constit$ended_date_value)] <- Sys.Date()
    
    constit2 <- constit[constit$started_date_value <= date1 & constit$ended_date_value >= date2,]
    
    constit2$ended_date_value[constit2$ended_date_value==Sys.Date()] <- NA 
    
    suppressMessages(elect <- hansard::elections())
    
    elect$about <- gsub("http://data.parliament.uk/resources/", "", elect$about)
    
    suppressMessages(elect_res <- hansard::election_results())
    
    elect_res$election_about <- gsub("http://data.parliament.uk/resources/", "", elect_res$election_about)
    
    elect_res2 <- dplyr::left_join(elect_res, elect, by = c("election_about"="about"))
    
    elect_res2 <- elect_res2[elect_res2$date_value <= date2,] 
    
    elect_res2 <- elect_res2[rev(order(elect_res2$date_value)),]
    
    elect_res2 <- subset(elect_res2,!duplicated(elect_res2$constituency_about))
    
    constit2$about <- gsub("http://data.parliament.uk/resources/", "", constit2$about)
    
    const_elect <- left_join(constit2, elect_res2, by = c("about"= "constituency_about"))
    
    df <- dplyr::left_join(mps, const_elect, by = c("member_from"= "constituency_label_value"))
    
    df$label_value.y <- NULL
    df$label_value.x <- NULL
    df$about.y <- NULL
    df$about.y.y <- NULL
    df$os_name <- NULL
    
    if (tidy == TRUE) {
    
      df <- parlitools_tidy(df, tidy_style)
    
    }
    
      df
  
  } else {
    
    if (tidy == TRUE) {
      
      mps <- parlitools_tidy(mps, tidy_style)

    } 
      
      mps
    
  }
    
}


