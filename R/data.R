

#' A hexagonal cartogram of Westminster parliamentary constituencies, stored as a simple feature. Originally downloaded from ESRI, with coordinates in Easting and Northing. Converted coordinates into Latitude and Longitude in QGIS.
#'
#' @format An sf and data.frame object, containing 650 elements and 8 variables.
#' \describe{
#'   \item{object_id}{Row Name}
#'   \item{constituency_name}{The name of the constituency}
#'   \item{description}{Description of constituency type}
#'   \item{gss_code}{The constituency GSS (Government Statistical Service) code}
#'   \item{region_name}{Name of region within the UK}
#'   \item{shape_length}{The lengths of the shape}
#'   \item{shape_area}{The area of shape}
#'   \item{geometry}{Shape geometry/projection}
#' }
#' @source \url{http://www.arcgis.com/home/item.html?id=15baaa6fecd54aa4b7250780b6534682}
"west_hex_map"

#' Hexagonal cartogram, of all Local Authorities in England, Wales and Scotland. Originally downloaded from ESRI, with coordinates in Easting and Northing. Converted coordinates into Latitude and Longitude in QGIS.
#'
#' @format An sf and data.frame object, containing 650 elements and 8 variables.
#' \describe{
#'   \item{object_id}{Row Name}
#'   \item{la_code}{Local Authority identifier code}
#'   \item{la_name}{Local Authority Name}
#'   \item{shape_length}{The lengths of the shape}
#'   \item{shape_area}{The area of the shape}
#'   \item{geometry}{Shape geometry/projection}
#' }
#' @source \url{http://www.arcgis.com/home/item.html?id=593037bc399e460bb7c6c631ceff67b4}
"local_hex_map"


#' A tibble with the ID, name and hex code for the official colour of a variety of political parties, taken from Wikipedia. Includes all political parties with MPs and a number without MPs.
#'
#' @format A tibble, containing 46 rows and 3 columns.
#' \describe{
#' \item{party_id}{The party ID, as assigned by the Members Name Information Service}
#' \item{party_name}{The name of the political party}
#' \item{party_colour}{A hex code for the party colour, as used by Wikipedia}
#' }
#' @source \url{https://en.wikipedia.org/wiki/Wikipedia:Index_of_United_Kingdom_political_parties_meta_attributes}
#' \url{http://data.parliament.uk/membersdataplatform/services/mnis/ReferenceData/Parties/}
"party_colour"


#' A tibble with the British Election Study 2015 Constituency Results Version 2.2. Variable names have been converted to snake_case and variables have been converted to appropriate R classes.
#' 
#' @references Fieldhouse, Edward, Jane Green, Geoffrey Evans, Hermann Schmitt, Cees van der Eijk, Jonathan Mellon, and Christopher Prosser. “British Election Study, 2015: General Election Results Dataset,” 2015. doi:10.13140/RG.2.1.1162.1844.
#'
#' @format A tibble, containing 632 rows and 277 columns.
#' @source \url{http://www.britishelectionstudy.com/data-object/2015-bes-constituency-results-with-census-and-candidate-data/}
"bes_2015"

