
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