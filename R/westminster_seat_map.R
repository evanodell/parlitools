


#' westminster_seat_map
#'
#'
#' 
#' @param date 
#' @param hex_map 
#'
#' @return Returns a map of all seats in the UK Parliament
#' @export
#'
#' @examples
#' 
#' 



westminster_seat_map <- function(date = Sys.Date(), hex_map = FALSE){
  
  ### Date of retrieval
  
  
  if(hex_map=TRUE){
    map <- rgdal::readOGR("./data/westminster_2010_2015_hex.kml")
  } else {
    map <- rgdal::readOGR("./data/westminster_2010_2015_cart.kml")
  }  
  
  
  
}







