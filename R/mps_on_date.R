
#' MPs on or between two dates
#'
#' Retrieve information on all MPs who were members of the House of Commons
#' on a date or between two dates.
#'
#' Returns information on all MPs who were members of the House of Commons on
#' the date specificed (if only one date is included as a parameter), or on or
#' between the two dates if both are specified. 
#' 
#' This function is identical to the `mnis_mps_on_date` function from
#' the `[mnis](https://cran.r-project.org/package=mnis)` package.
#'
#' @param date1 The date to return the list of MPs from. Accepts character
#' values in `'YYYY-MM-DD'` format, and objects of class `Date`,
#' `POSIXt`, `POSIXct`, `POSIXlt` or anything else than can
#' be coerced to a date with `as.Date()`. Defaults to current system date.
#' @param date2 An optional query parameter. Accepts character values in
#' `'YYYY-MM-DD'` format, and objects of class `Date`,
#' `POSIXt`, `POSIXct`, `POSIXlt` or anything else than can
#' be coerced to a date with `as.Date()`. If a proper date, the function
#' returns a list of all MPs who were members between `date2` and
#' `date1`. Defaults to `NULL`.
#' @param tidy If `TRUE`, fixes the variable names in the tibble to
#' remove special characters and superfluous text, and converts the variable
#' names to a consistent style. Defaults to `TRUE`.
#' @param tidy_style The style to convert variable names to,
#' if `tidy = TRUE`. Accepts one of `'snake_case'`,
#' `'camelCase'` and `'period.case'`. Defaults to `'snake_case'`.
#'
#' @return A tibble with information on all MPs who were members of the House
#' of Commons on the date specificed (if only `date1` is included as a
#' parameter), or on or between the two dates if both `date1` and
#' `date2` are specified.
#' @export
#'
#' @examples \dontrun{
#' x <- mps_on_date(date1 = "2017-04-19", date2 = "2010-05-04")
#' }

mps_on_date <- function(date1 = Sys.Date(), date2 = NULL, constituency = FALSE,
                        tidy = TRUE, tidy_style = "snake_case") {
  mps <- mnis::mnis_mps_on_date(date1 = date1, date2 = date2, 
                                tidy = tidy, tidy_style = tidy_style)
  
  mps
}
