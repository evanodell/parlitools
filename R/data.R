

#' A hexagonal cartogram of Westminster parliamentary constituencies. Originally downloaded from ESRI, with coordinates in Easting and Northing. Converted coordinates into Latitude and Longitude in QGIS.
#' 
#' 
#'
#' @format A SpatialPolygonsDataFrame, containing 650 elements
#' \describe{
#' }
#' @source \url{http://www.arcgis.com/home/item.html?id=15baaa6fecd54aa4b7250780b6534682}
"west_hex_map"


#' A tibble with the ID, name and hex code for the official colour of a variety of political parties, taken from Wikipedia. Includes all political parties with MPs and a number without MPs.
#' 
#' 
#'
#' @format A tibble, containing 46 rows and 3 columns.
#' \describe{
#' }
#' @source \url{https://en.wikipedia.org/wiki/Wikipedia:Index_of_United_Kingdom_political_parties_meta_attributes}
#' \url{http://data.parliament.uk/membersdataplatform/services/mnis/ReferenceData/Parties/}
"party_colour"


#' A tibble with the British Election Study 2015 Constituency Results Version 2.2.
#' 
#' @references British Election Study 2015 Constituency Results Version 2.2. DOI: 10.13140/RG.2.1.1162.1844
#'
#' @format A tibble, containing 46 rows and 3 columns.
#' \describe{
#' }
#' @source \url{http://www.britishelectionstudy.com/data-object/2015-bes-constituency-results-with-census-and-candidate-data/}
"bes_2015"

