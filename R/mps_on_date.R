#' Request information on all MPs who were members of the House of Commons on the date specificed (if only one date is included as a parameter), or on or between the two dates if two are specified. Includes constituency and electoral information if the date is 2010-05-06 or later, or if the date range is entirely within 2010-05-06 and the present day.
#'
#' @param date1 The date to return the list of MPs from. Accepts character values in "YYYY-MM-DD" format, and objects of class Date, POSIXt, POSIXct, POSIXlt or anything else than can be coerced to a date with \code{as.Date()}. Defaults to current system date. 
#' @param date2 An optional query parameter. Accepts character values in "YYYY-MM-DD" format, and objects of class Date, POSIXt, POSIXct, POSIXlt or anything else than can be coerced to a date with \code{as.Date()}. If a proper date, the function returns a list of all MPs who were members between date2 and date1. Defaults to NULL.
#' @param tidy Fix the variable names in the tibble to remove special characters and superfluous text, and converts the variable names to a consistent style. Defaults to TRUE.
#' @param tidy_style The style to convert variable names to, if tidy=TRUE. Accepts one of "snake_case", "camelCase" and "period.case". Defaults to "snake_case"
#'
#' @return A tibble with information on all MPs who were members of the House of Commons on the date specificed (if only date1 is included as a parameter), or on or between the two dates if both date1 and date2 are specified.
#' @export
#'
#' @examples \dontrun{
#'
#' x <- mps_on_date(date1="2017-04-19", date2="2010-05-04")
#'
#' }


mps_on_date <- function(date1 = Sys.Date(), date2=NULL, tidy = TRUE, tidy_style="snake_case"){
  
  message("Downloading MP data")
  
    mps <- mnis::mnis_mps_on_date(date1, date2, tidy, tidy_style)
    
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
    
  if(date1 >= "2010-05-06"){
    
    mps <- mnis::mnis_tidy(mps, "snake_case")
    
    message("Downloading constituency data")
    
    suppressMessages(constit <- hansard::constituencies(current = FALSE))
    
    constit$ended_date_value[is.na(constit$ended_date_value)] <- Sys.Date()
    
    constit2 <- constit[constit$started_date_value <= date1 & constit$ended_date_value >= date2,]
    
    constit2$ended_date_value[constit2$ended_date_value==Sys.Date()] <- NA 
    
    suppressMessages(elect <- elections())
    
    suppressMessages(elect_res <- election_results())
    
    elect_res <- dplyr::right_join(elect, elect_res, by = c("about"="election_about", "label_value"="election_label_value"))
    
    elect_res <- elect_res[elect_res$date_value <= date2,] 
    
    elect_res <- elect_res[rev(order(elect_res$date_value)),]
    
    elect_res <- subset(elect_res,!duplicated(elect_res$constituency_about))
    
    const_elect <- left_join(constit2, elect_res, by = c("about"= "constituency_about"))
    
    df <- dplyr::left_join(mps, const_elect, by = c("member_from"= "constituency_label_value"))
    
    df$label_value.y <- NULL
    df$label_value.x <- NULL
    df$about.y <- NULL
    df$about.y.y <- NULL
    df$os_name <- NULL
    
    if (tidy == TRUE) {
    
      df <- parlitools::parlitools_tidy(df, tidy_style)
    
      df
    
    } else {
    
    df
    
  }
  
  } else {
    
    if (tidy == TRUE) {
      
      mps <- parlitools::parlitools_tidy(mps, tidy_style)
      
      mps
      
    } else {
      
      mps
      
    }
    
  }
    
}


