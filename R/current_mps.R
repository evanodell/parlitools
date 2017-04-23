#' current_mps
#' 
#' @param tidy Fix the variable names in the tibble to remove extra characters, superfluous text and convert variable names to snake_case. Defaults to TRUE.
#' @return A tibble of all MPs currently eligible to sit in the House of Commons
#' @export
#'
#' @examples \dontrun{
#'
#' x <- current_mps()
#'
#' }
 
current_mps <- function(tidy=TRUE){
  
  constit <- hansard::constituencies(tidy=tidy)
  
  current <- mnis::mnis_eligible(house="commons", tidy=tidy)  
  
  current_mps <- dplyr::left_join(current, constit, by = c("member_from"= "label_value"))
  
  current_mps
  
}