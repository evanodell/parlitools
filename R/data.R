

#' A hexagonal cartogram of Westminster parliamentary constituencies, stored as a simple feature. 
#' 
#' Originally created by Ben Flanagan at ESRI, with coordinates in Easting and Northing. The coordinates in the original shapefile were converted into Latitude and Longitude in QGIS, and the hexagon representing Ynys Mon was moved to be closer to the mainland of Wales.
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

#' Hexagonal cartogram, of all Local Authorities in England, Wales and Scotland. 
#' 
#' Originally created by Ben Flanagan at ESRI, with coordinates in Easting and Northing. Converted coordinates into Latitude and Longitude in QGIS.
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


#' A tibble with the ID, name and hex code for the official colour of a variety of political parties. 
#' 
#' Includes all political parties with MPs and a number without MPs. It also contains a 'No Overall Control' party for local government. Hex codes are taken from Wikipedia.
#'
#' @format A tibble, containing 47 rows and 3 columns.
#' \describe{
#' \item{party_id}{The party ID, as assigned by the Members Name Information Service}
#' \item{party_name}{The name of the political party}
#' \item{party_colour}{A hex code for the party colour, as used by Wikipedia}
#' }
#' @source \url{https://en.wikipedia.org/wiki/Wikipedia:Index_of_United_Kingdom_political_parties_meta_attributes}
#' \url{http://data.parliament.uk/membersdataplatform/services/mnis/ReferenceData/Parties/}
"party_colour"


#' A tibble with the British Election Study 2015 Constituency Results Version 2.21.
#' 
#' A tibble with constituencies results from the British Election Study 2015, linked to census data for each constituency. Only covers Great Britain, so data on Northern Irish constituencies is not included.
#' 
#' Variable names have been converted to snake_case and variables have been converted to appropriate R classes.
#' 
#' @references Fieldhouse, Edward, Jane Green, Geoffrey Evans, Hermann Schmitt, Cees van der Eijk, Jonathan Mellon, and Christopher Prosser. "British Election Study, 2015: General Election Results Dataset," 2015. doi:10.13140/RG.2.1.1162.1844.
#'
#' @format A tibble, containing 632 rows and 277 columns. For details on all variables in the dataset please see the vignette: \url{http://docs.evanodell.com/parlitools/articles/bes-2015.html}
#' @source \url{http://www.britishelectionstudy.com/data-object/2015-bes-constituency-results-with-census-and-candidate-data/}
"bes_2015"



#' A tibble with the results of the 2017 general election.
#' 
#' A tibble with Great Britain constituencies results from the 2017 general election. This data can be linked to 2011 census information in \code{\link{bes_2015}}. 
#' 
#' Variable names have been converted to snake_case and variables have been converted to appropriate R classes.
#' 
#' @format A tibble, containing 632 row and 58 columns. 
#' \describe{
#'\item{pano}{Press Association Constituency ID. Numeric.}
#'\item{onsconst_id}{ONS Constituency ID. Character.}
#'\item{constituency_name}{Constituency Name. Factor.}
#'\item{country}{Country. Factor.}
#'\item{region}{Region. Factor.}
#'\item{constituency_type}{County or Borough Constituency. Factor.}
#'\item{winner_17}{2017 Winning party. Factor.}
#'\item{electorate_17}{2017 Size of electorate. Numeric.}
#'\item{total_vote_17}{2017 Total number of votes cast. Numeric.}
#'\item{rejected_vote_17}{2017 Number of rejected ballots. Numeric.}
#'\item{majority_17}{2017 Majority. Numeric.}
#'\item{majority_17}{2017 Majority. Numeric.}
#'\item{turnout_17}{2017 Turnout. Numeric.}
#'\item{seat_change_1517}{2017 winning party gain from 2015 winning party. Factor.}
#'\item{con_vote_17}{2017 Conservative number of votes. Numeric.}
#'\item{lab_vote_17}{2017 Labour number of votes. Numeric.}
#'\item{ld_vote_17}{2017 Liberal Democrat number of votes. Numeric.}
#'\item{ukip_vote_17}{2017 United Kingdom Independence Party (UKIP) number of votes. Numeric.}
#'\item{green_vote_17}{2017 Green Party number of votes. Numeric.}
#'\item{snp_vote_17}{2017 Scottish National Party (SNP) number of votes. Numeric.}
#'\item{pc_vote_17}{2017 Plaid Cymru number of votes. Numeric.}
#'\item{other_vote_17}{2017 Other vote share. Numeric.}
#'\item{con_17}{2017 Conservative vote share. Numeric.}
#'\item{lab_17}{2017 Labour vote share. Numeric.}
#'\item{ld_17}{2017 Liberal Democrat vote share. Numeric.}
#'\item{snp_17}{2017 Scottish National Party (SNP) vote share. Numeric.}
#'\item{pc_17}{2017 Plaid Cymru vote share. Numeric.}
#'\item{ukip_17}{2017 United Kingdom Independence Party (UKIP) vote share. Numeric.}
#'\item{green_17}{2017 Green Party vote share. Numeric.}
#'\item{other_17}{2017 Combined other vote share. Numeric.}
#'\item{con_1517}{2015-17 Conservative vote share change. Numeric.}
#'\item{lab_1517}{2015-17 Labour vote share change. Numeric.}
#'\item{ld_1517}{2015-17 Liberal Democrat vote share change. Numeric.}
#'\item{snp_1517}{2015-17 Scottish National Party (SNP) vote share change. Numeric.}
#'\item{pc_1517}{2015-17 Plaid Cymru vote share change. Numeric.}
#'\item{ukip_1517}{2015-17 United Kingdom Independence Party (UKIP) vote share change. Numeric.}
#'\item{green_1517}{2015-17 Green Party vote share change. Numeric.}
#'\item{winner_15}{2015 Winning party. Factor.}
#'\item{con_15}{2015 Conservative vote share. Numeric.}
#'\item{lab_15}{2015 Labour vote share. Numeric.}
#'\item{ld_15}{2015 Liberal Democrat vote share. Numeric.}
#'\item{snp_15}{2015 Scottish National Party (SNP) vote share. Numeric.}
#'\item{pc_15}{2015 Plaid Cymru vote share. Numeric.}
#'\item{ukip_15}{2015 United Kingdom Independence Party (UKIP) vote share. Numeric.}
#'\item{green_15}{2015 Green Party vote share. Numeric.}
#'\item{other_15}{2015 Combined other vote share. Numeric.}
#'\item{majority_15}{2015 Majority. Numeric.}
#'\item{turnout_15}{2015 Turnout. Numeric.}
#'\item{con_vote_15}{2015 Conservative number of votes. Numeric.}
#'\item{lab_vote_15}{2015 Labour number of votes. Numeric.}
#'\item{ldvote_15}{2015 Liberal Democrat number of votes. Numeric.}
#'\item{snpvote_15}{2015 Scottish National Party (SNP) number of votes. Numeric.}
#'\item{pcvote_15}{2015 Plaid Cymru number of votes. Numeric.}
#'\item{ukipvote_15}{2015 United Kingdom Independence Party (UKIP) number of votes. Numeric.}
#'\item{green_vote_15}{2015 Green Party number of votes. Numeric.}
#'\item{bnpvote_15}{2015 British National Party (BNP) number of votes. Numeric.}
#'\item{total_vote_15}{2015 Total number of votes cast. Numeric.}
#'\item{rejected_vote_15}{2015 Number of rejected ballots. Numeric.}
#'\item{electorate_15}{2015 Size of electorate. Numeric.}
#' }
#' @source \url{researchbriefings.parliament.uk/ResearchBriefing/Summary/CBP-7979} \url{http://www.britishelectionstudy.com/data-object/2015-bes-constituency-results-with-census-and-candidate-data/}
"ge_2017"


#' A tibble with details on the council make-up of local authorities across the UK.
#' 
#' This data is taken from \url{http://opencouncildata.co.uk/}, run by Jon Lawson. Variable names have been converted to snake_case and variables have been converted to appropriate R classes. ONS local authority codes have been taken from the \code{local_hex_map} data, and from the ONS's Open Geography Portal. This data is accurate as of 2017-06-02.
#' 
#' @format A tibble, with 418 rows and 20 columns.
#' \describe{
#' \item{la_code}{The Local Authority code from the Office for National Statistics}
#' \item{name}{Local Authority Name}
#' \item{type}{The type of local authority}
#' \item{majority_party}{The majority party on the council. The label 'No Overall Control' is used if no single party has a majority.}
#' \item{majority_party_id}{The ID of the majority party on the council. The label 'noc' is used if no single party has a majority.}
#' \item{governing_coalition}{The governing coalition of the council (if known)}
#' \item{conservative_councillors}{The number of Conservative councillors}
#' \item{labour_councillors}{The number of Labour councillors}
#' \item{lib_dem_councillors}{The number of Liberal Democrat councillors}
#' \item{green_councillors}{The number of Green councillors}
#' \item{ukip_councillors}{The number of UKIP councillors}
#' \item{plaid_cymru_councillors}{The number of Plaid Cymru councillors}
#' \item{snp_councillors}{The number of SNP councillors}
#' \item{independent_councillors}{The number of Independent councillors}
#' \item{vacant}{The number of vacant seats on the council}
#' \item{total_councillors}{Total number of vacant council seats}
#' \item{boundary}{Notes on upcoming boundary changes}
#' \item{notes}{Notes from Open Council Data UK}
#' \item{url}{URL}
#' \item{last_update}{Date of last update}
#' }
#' @source \url{http://opencouncildata.co.uk/councils.php?model=}
#' \url{http://geoportal.statistics.gov.uk/datasets/464be6191a434a91a5fa2f52c7433333_0}
"council_data"


#' A tibble with details on percentage of votes cast for leave in the 2016 referendum on British membership of the European Union in each  constituency. 
#' 
#' A tibble with details on percentage of votes cast for leave in the 2016 referendum on British membership of the European Union in each  constituency. Numbers for Britian were compiled by the House of Commons using data from Chris Hanretty's estimates of leave vote, and supplemented with data from BBC Freedom of Information requests for more finely grained voting data. Numbers for Northern Ireland, which reported results by constituency, are taken from the BBC.
#' @format A tibble, with 641 rows and 7 columns.
#' \describe{
#' \item{gss_code}{ONS code for constituency}
#' \item{constituency}{The name of the constituency.}
#' \item{party_2016}{The party holding the constituency on 23 June 2016, the date of the referendum.}
#' \item{ch_leave_vote}{Estimates of the leave vote produced by Chris Hanretty.}
#' \item{known_leave_vote}{A dummy variable indicating 'yes' if the actual leave vote percentage is known, and 'no' if the estimate by CHris Hanretty is available.}
#' \item{known_leave_vote_perc}{The percentage of votes cast for leave, if known.}
#' \item{difference_estimate_known}{Difference between the estimate by Chris Hanretty and the actual result, if known.}
#' }
#' @source \url{https://secondreading.uk/brexit/brexit-votes-by-constituency/}
#' \url{http://www.bbc.co.uk/news/uk-northern-ireland-36616830}
"leave_votes_west"
