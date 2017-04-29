#' current_mps
#' 
#' @param tidy Fix the variable names in the tibble to remove extra characters, superfluous text and convert variable names to snake_case. Defaults to TRUE.
#' @return A tibble of all MPs currently eligible to sit in the House of Commons.
#' @export
#'
#' @examples \dontrun{
#'
#' x <- current_mps()
#'
#' }
 
current_mps <- function(tidy=TRUE){
  
  suppressMessages(constit <- hansard::constituencies(tidy=tidy))
  
  if(packageVersion("mnis")>"0.2.3") {
  
  current <- mnis::mnis_eligible(house="commons", tidy=tidy)
  
  current$member_from <- gsub("Ynys M\U00C1\U00B4n", "Ynys M\U00F4n", current$member_from)
  
  } else {
    
    x <- mnis::mnis_eligible(house="commons", tidy=tidy)
    
    current <- tibble::as_tibble(mnis::mnis_tidy(x$members$Member))
    
    current$member_from <- gsub("Ynys M\U00C1\U00B4n", "Ynys M\U00F4n", current$member_from)
    
  }
  
  df <- dplyr::left_join(current, constit, by = c("member_from"= "label_value"))
  
  df
  
}
