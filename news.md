# parlitools 0.2.1

## Data

Updating of `council_data` dataset to be accurate as of 2017-09-13.

Added `combined_leave_vote` column to `leave_votes_west` dataset with the actual leave vote if known and the Chris Hanretty estimate if not known. 

Vote percentages in `leave_votes_west` are now all numeric class.

## Dependency changes

Removed reliance on now-hidden functions from `mnis` and `hansard` packages.

## General improvements

Improvements to documentation to improve clarity and readability. 

Better example plots in introductory vignette.

The tidying functions are now all internal to the package and not exported.

# parlitools 0.2.0

## Data

New `bes_2017` dataset, with results of 2017 General Election, taken from the 2017 British Election Study. This dataset replaces the `ge_2017` dataset. It also replicates some of the data in the `bes_2015` dataset.

Census data from the British Election Study has been moved to its own seperate file, named `census11`.

## Fixes

Naming conventions for variables now places an underscore between each distinct word (eg `onsconst_id` is now `ons_const_id`)

# parlitools 0.1.0

Changes to vignettes to comply with CRAN policies and to reduce the time needed to check the package.

Reduction in the number of similar vignette examples to reduce build time.

## Data

Updating of `council_data` dataset to be accurate as of 2017-07-14.

New `ge_2017` dataset, with results of 2017 General Election, linked with constituency data from `bes_2015`.

## Bug fixes

Consistent naming of vote variables in `bes_2015`.

# parlitools 0.0.7

Updated documentation, more comprehensive testing. Added Northern Irish EU Referendum results to the `leave_votes_west` dataset.

# parlitools 0.0.6

## Bug fixes

Fixed bugs in `mps_on_date()` that were causing problems on Windows.

# parlitools 0.0.5

## Data updates

Added `leave_votes_west` containing estimates and - where available - official counts of the proportion of leave votes in the 2016 EU referendum.

# parlitools 0.0.4

## Data updates

Updated `bes_2015` to use V2.21 from the British Election Study.

Added `council_data` dataset, with details on the parties controlling local councils across the UK.

## Bug Fixes

A few minor tweaks to internal code, and to the vignette examples.

# parlitools 0.0.3

## Bug Fixes

Fixed bug in `mps_on_date` where function did not return constituency data. `mps_on_date` also now accepts dates in any format or class that can be converted with `as.Date()` to a date format.

Fixed names party names in `party_colour` to align with names used in `bes_2015`.

Fixed spelling mistakes in Endiburgh constituency names in `bes_2015`.

## New Features

Added optional `tidy_style` parameter in `current_mps()` and `mps_on_date()`, allowing users to decide which style snake_case, camelCase and period.case they want variable names to be in, if 'tidy'==TRUE.

# parlitools 0.0.2

Added an additional vignette on using the data in `parlitools` to create scaled maps with the `cartogram` package.

### Maps

Now includes `local_hex_map`, a hexagonal map of all local authority areas in Scotland, Wales and England.

### Data Retrieval

The `mps_on_date` function downloads information on every MP and their constituency who was a member of the house on a single given date, or between two given dates.

# parlitools 0.0.1

## Introducing parlitools

Introducing `parlitools`, a package for retrieving and analysing UK political data. The package includes datasets from the British Election Study, a hexagonal map of all UK constituencies, and party colour hex codes.

### Data

The package includes a dataset with 2015 General Election results and census information for each constituency in Scotland, Wales and England, taken from the British Election Study.

The package also includes a dataset (`party_colours`) with the hex code for the official colours of UK political parties.

### Maps

Includes a hexagonal map (`west_hex_map`) of all 650 constituencies in the UK.

### Data Retrieval

The `current_mps` function downloads information on every sitting MP and their constituency.