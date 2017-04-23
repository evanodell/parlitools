
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)]() [![Travis-CI Build Status](https://travis-ci.org/EvanOdell/parlitools.svg?branch=master)](https://travis-ci.org/EvanOdell/parlitools)

parlitools
==========

A collection of useful tools for UK politics, including base maps and datasets.

Data
----

`party_colours` - A tibble with the ID, name and hex code for the official colour of a variety of political parties, taken from Wikipedia. Includes all political parties with MPs and a number without MPs.

`bes_2015` - A tibble with the British Election Study 2015 Constituency Results Version 2.2. (source: <http://www.britishelectionstudy.com/data-object/2015-bes-constituency-results-with-census-and-candidate-data/>)

Tibbles with spending data from all candidates in the 2001, 2005, 2010 and 2015 General Elections. Named `spending_2001`, `spending_2005`, `spending_2010` and `spending_2015`.

Data Retrieval
--------------

`current_mps` - Uses functions from `hansard` and `mnis` to create a tibble with data on all current MPs, their party affiliation and their constituency.

Maps
----

`west_hex_map` - A hexagonal cartogram of Westminster parliamentary constituencies.

Vignette
--------

For more details, please see the [vignette](http://evanodell.com/parlitools/articles/introduction.html).
