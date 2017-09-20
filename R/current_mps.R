#' All current MPs
#' 
#' Request data on all MPs eligible currently (i.e. on the current system date) to sit in the House of Commons. Includes information on their constituency.
#' 
#' @param tidy If \code{TRUE}, fixes the variable names in the tibble to remove special characters and superfluous text, and converts the variable names to a consistent style. Defaults to \code{TRUE}.
#' @param tidy_style The style to convert variable names to, if \code{tidy=TRUE}. Accepts one of \code{'snake_case'}, \code{'camelCase'} and \code{'period.case'}. Defaults to \code{'snake_case'}.
#' @return A tibble of all MPs currently eligible to sit in the House of Commons.
#' @export
#'
#' @examples \dontrun{
#' x <- current_mps()
#' }
 
current_mps <- function(tidy=TRUE, tidy_style="snake_case"){
  
  suppressMessages(constit <- hansard::constituencies(current=TRUE, tidy=FALSE))
    
  current <- mnis::mnis_eligible(house="commons", tidy=FALSE)
    
  if(.Platform$OS.type=="windows"){
    
    current$MemberFrom <- stringi::stri_trans_general(current$MemberFrom, "latin-ascii")
    
    current$MemberFrom <- gsub("Ynys MA\U00B4n", "Ynys M\U00F4n", current$MemberFrom)

  }
  
  df <- dplyr::right_join(current, constit, by = c("MemberFrom" = "label._value"))
  
  if(tidy==TRUE){
    
    df$startedDate._value <- as.POSIXct(df$startedDate._value)
    
    df$startedDate._datatype <- "POSIXct"
    
    df$CurrentStatus.StartDate <-  gsub("T", " ", df$CurrentStatus.StartDate)
    
    df$CurrentStatus.StartDate <- as.POSIXct(df$CurrentStatus.StartDate)
    
    df$HouseStartDate <- gsub("T", "", df$HouseStartDate)
    
    df$HouseStartDate <- as.POSIXct(df$HouseStartDate)
    
    df$DateOfBirth <- as.character(df$DateOfBirth)
    
    df$DateOfBirth <-  gsub("T00:00:00", "", df$DateOfBirth)
    
    df$DateOfBirth <- as.Date(df$DateOfBirth)
    
    df$DateOfBirth <- as.POSIXct(df$DateOfBirth)
    
    df <- parlitools_tidy(df, tidy_style)
    
  }
  
  df
  
}
