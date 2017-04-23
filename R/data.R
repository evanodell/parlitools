

#' A hexagonal cartogram of Westminster parliamentary constituencies, stored as a simple feature. Originally downloaded from ESRI, with coordinates in Easting and Northing. Converted coordinates into Latitude and Longitude in QGIS.
#'
#' @format A SpatialPolygonsDataFrame, containing 650 elements
#' \describe{
#' }
#' @source \url{http://www.arcgis.com/home/item.html?id=15baaa6fecd54aa4b7250780b6534682}
"west_hex_map"


#' A tibble with the ID, name and hex code for the official colour of a variety of political parties, taken from Wikipedia. Includes all political parties with MPs and a number without MPs.
#'
#' @format A tibble, containing 46 rows and 3 columns.
#' \describe{
#' }
#' @source \url{https://en.wikipedia.org/wiki/Wikipedia:Index_of_United_Kingdom_political_parties_meta_attributes}
#' \url{http://data.parliament.uk/membersdataplatform/services/mnis/ReferenceData/Parties/}
"party_colour"


#' A tibble with the British Election Study 2015 Constituency Results Version 2.2. Variable names have been converted to snake_case.
#' 
#' @references British Election Study 2015 Constituency Results Version 2.2. DOI: 10.13140/RG.2.1.1162.1844
#'
#' @format A tibble, containing 46 rows and 3 columns.
#' \describe{
#' }
#' @source \url{http://www.britishelectionstudy.com/data-object/2015-bes-constituency-results-with-census-and-candidate-data/}
"bes_2015"

#' A tibble with the election spending of all candidates in the 2001 General Election. Variable names have been converted to snake_case.
#' 
#'
#' @format A tibble with 3291 rows and 22 columns.
#' \describe{
#' }
#' @source \url{http://www.electoralcommission.org.uk/find-information-by-subject/elections-and-referendums/past-elections-and-referendums/uk-general-elections/candidate-election-spending}
"spending_2001"


#' A tibble with the election spending of all candidates in the 2005 General Election. Variable names have been converted to snake_case.
#' 
#'
#' @format A tibble with 3554 rows and 26 columns.
#' \describe{
#' }
#' @source \url{http://www.electoralcommission.org.uk/find-information-by-subject/elections-and-referendums/past-elections-and-referendums/uk-general-elections/candidate-election-spending}
"spending_2005"


#' A tibble with the election spending of all candidates in the 2010 General Election. Variable names have been converted to snake_case.
#' 
#'
#' @format A tibble with 4031 rows and 52 columns.
#' \describe{
#' }
#' @source \url{http://www.electoralcommission.org.uk/find-information-by-subject/elections-and-referendums/past-elections-and-referendums/uk-general-elections/candidate-election-spending}
"spending_2010"


#' A tibble with the election spending of all candidates in the 2015 General Election. Variable names have been converted to snake_case.
#' 
#'
#' @format A tibble with 3971 rows and 50 columns.
#' \describe{
#' }
#' @source \url{http://www.electoralcommission.org.uk/find-information-by-subject/elections-and-referendums/past-elections-and-referendums/uk-general-elections/candidate-election-spending}
"spending_2015"
