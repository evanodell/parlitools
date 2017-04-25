
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)]() [![GitHub tag](https://img.shields.io/github/tag/evanodell/parlitools.svg)](https://github.com/evanodell/parlitools) [![](http://cranlogs.r-pkg.org/badges/grand-total/parlitools)](https://dgrtwo.shinyapps.io/cranview/) [![Travis-CI Build Status](https://travis-ci.org/EvanOdell/parlitools.svg?branch=master)](https://travis-ci.org/EvanOdell/parlitools) [![DOI](https://zenodo.org/badge/86801920.svg)](https://zenodo.org/badge/latestdoi/86801920) [![Coverage Status](https://img.shields.io/codecov/c/github/EvanOdell/parlitools/master.svg)](https://codecov.io/github/EvanOdell/parlitools?branch=master)

parlitools
==========

A collection of useful tools for UK politics, including base maps and datasets. Initially inspired by Bhaskar Karambelkar's [`tilegrams`](https://cran.r-project.org/package=tilegramsR) package, but with the ability to create a hexagonal map of UK parliamentary constituencies. The package also includes functions for data retrieval of current MPs and their consituency details (as it requires calls to two different APIs, this function is not included in my [`hansard`](https://cran.r-project.org/package=hansard) or [`mnis`](https://cran.r-project.org/package=mnis) packages), and data from the 2015 UK General Election, courtesy of the British Election Study.

Installing
----------

At present `parlitools` is only available on GitHub, although a CRAN release is being planned, ahead of the 2017 UK General Election.

To install the current version from GitHub, run:

    devtools::install_github("evanodell/parlitools")

You will also need the development version of `mnis`:

    devtools::install_github("evanodell/mnis")

Data
----

`party_colours` - A tibble with the ID, name and hex code for the official colour of a variety of political parties, taken from Wikipedia. Includes all political parties with MPs and a number without MPs.

`bes_2015` - A tibble with the British Election Study 2015 Constituency Results Version 2.2. (Source: <http://www.britishelectionstudy.com/data-object/2015-bes-constituency-results-with-census-and-candidate-data/>)

Data Retrieval
--------------

`current_mps` - Uses functions from `hansard` and `mnis` to create a tibble with data on all current MPs, their party affiliation and their constituency.

Maps
----

`west_hex_map` - A hexagonal cartogram of Westminster parliamentary constituencies.

Using `parlitools`
------------------

For more details, please see the [vignette](http://evanodell.com/parlitools/articles/introduction.html).
