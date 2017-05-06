
# parlitools 0.0.3

## Bug Fix

Fixed bug in `mps_on_date` where function did not return constituency data.

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