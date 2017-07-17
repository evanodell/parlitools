<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- rmarkdown v1 --> 

<!--to accomodate pandoc bug on windows-->



[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/evanodell/parlitools/blob/master/LICENSE)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/parlitools)](https://cran.r-project.org/package=parlitools)
[![GitHub tag](https://img.shields.io/github/tag/evanodell/parlitools.svg)](https://github.com/evanodell/parlitools)
[![](https://cranlogs.r-pkg.org/badges/grand-total/parlitools)](https://dgrtwo.shinyapps.io/cranview/)
[![Travis-CI Build Status](https://travis-ci.org/evanodell/parlitools.svg?branch=master)](https://travis-ci.org/evanodell/parlitools)
[![DOI](https://zenodo.org/badge/86801920.svg)](https://zenodo.org/badge/latestdoi/86801920)
[![Coverage Status](https://img.shields.io/codecov/c/github/evanodell/parlitools/master.svg)](https://codecov.io/github/evanodell/parlitools?branch=master)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/evanodell/parlitools?branch=master&svg=true)](https://ci.appveyor.com/project/evanodell/parlitools)

# parlitools

A collection of useful tools for UK politics, including base maps and datasets. Initially inspired by Bhaskar Karambelkar's [`tilegrams`](https://cran.r-project.org/package=tilegramsR) package, but with the ability to create a hexagonal map of UK parliamentary constituencies. The package also includes functions for data retrieval of current MPs and their consituency details (as it requires calls to two different APIs, this function is not included in my [`hansard`](https://cran.r-project.org/package=hansard) or [`mnis`](https://cran.r-project.org/package=mnis) packages), and data from the 2015 UK General Election, courtesy of the British Election Study.

The most up-to-date documentation for the development version will always be at http://docs.evanodell.com/parlitools/. 

## Installing

`parlitools` is available on CRAN. To install on CRAN run:

```
install.packages("parlitools")
```

Or, if you use [pacman](https://cran.r-project.org/package=pacman):

```
pacman::p_load(parlitools)
```

To install the development version from GitHub, run:

```
##install.packages("parlitools")
devtools::install_github("evanodell/parlitools")
```

## Functions and Data

For more details see [the full documentation](http://docs.evanodell.com/parlitools/).

### Included Data


[`party_colour`](https://docs.evanodell.com/parlitools/reference/party_colour.html) - A tibble with the ID, name and hex code for the official colour of a variety of political parties, taken from Wikipedia. Includes all political parties with MPs and a number without MPs. (Sources: https://en.wikipedia.org/wiki/Wikipedia:Index_of_United_Kingdom_political_parties_meta_attributes, [`mnis::ref_parties()`](https://cran.r-project.org/package=mnis))

[`bes_2015`](https://docs.evanodell.com/parlitools/reference/bes_2015.html) - A tibble with the British Election Study 2015 Constituency Results Version 2.2. For information on all the variables in this dataset, see the [bes-2015 vignette](http://docs.evanodell.com/parlitools/articles/bes-2015.html) (Source: http://www.britishelectionstudy.com/data-object/2015-bes-constituency-results-with-census-and-candidate-data/)

[`ge_2017`](https://docs.evanodell.com/parlitools/reference/ge_2017.html) - A tibble with Great Britain constituencies results from the 2017 general election. This data can be linked to 2011 census information in [`bes_2015`](https://docs.evanodell.com/parlitools/reference/bes_2015.html).

[`council_data`](https://docs.evanodell.com/parlitools/reference/council_data.html) - A tibble with data on the size of each local council (in terms of councillors), and the party or parties controlling the council.  (Sources: http://opencouncildata.co.uk/councils.php?model=, http://geoportal.statistics.gov.uk/datasets/464be6191a434a91a5fa2f52c7433333_0). Last updated 14 July 2017.

[`leave_votes_west`](https://docs.evanodell.com/parlitools/reference/leave_votes_west.html) - The percentage of votes cast for leave in the 2016 EU referendum. Some constituencies have actual results and others only have estimates by Chris Hanretty; in cases where the actual cote count is known, both the estimates and the actual results are reported. (Sources: https://secondreading.uk/brexit/brexit-votes-by-constituency/ http://www.bbc.co.uk/news/uk-northern-ireland-36616830)


### Data Retrieval Functions

`current_mps` - Uses functions from `hansard` and `mnis` to create a tibble with data on all current MPs, their party affiliation and their constituency.

`mps_on_date`  - Uses functions from `hansard` and `mnis` to create a tibble with data on all MPs from a given date, their party affiliation and their constituency.

### Included Maps

`west_hex_map` - A hexagonal cartogram, stored as a simple feature and data frame, of Westminster parliamentary constituencies. `west_hex_map` can be used to create maps like this:

<img src="tools/hex_map.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="456px" />

`local_hex_map` - Hexagonal cartogram, A hexagonal cartogram, stored as a simple feature and data frame, of all Local Authorities in England, Wales and Scotland.

### Using `parlitools`

For more details, please see the [introductory vignette](https://docs.evanodell.com/parlitools/articles/introduction.html), [using `parlitools` with `cartogram`](https://docs.evanodell.com/parlitools/articles/using-cartograms.html), [mapping local authorities](https://docs.evanodell.com/parlitools/articles/mapping-local-authorities.html) and the vignette detailing [British Election Study 2015](https://docs.evanodell.com/parlitools/articles/bes-2015.html) variables.

## Data Sources

There are a variety of potentially relevant data sources and datasets on UK politics, far too many for me to include them all in this package.

* [Electoral Commission](http://www.electoralcommission.org.uk/our-work/our-research/electoral-data) - Electoral results dating back to 2005.

* [British Election Study](http://www.britishelectionstudy.com/data/) - A large selection of open data, including panel surveys, linked data and aggregated Twitter data, covering elections and referenda.

* [`hansard`](https://cran.r-project.org/package=hansard) & [`mnis`](https://cran.r-project.org/package=mnis) data retrieval packages for parliamentary APIs.

* [Open Council Data](http://opencouncildata.co.uk/) has data on the names, parties, and wards of all UK councillors, updated more or less weekly.
