
# parlitools_tidy
#
# A function to make the results of calls to the API easier to work with,
# mostly though fixing variable names, which by default contain non
# alpha-numeric characters and appear to use an inconsistent/idiosyncratic
# naming convention, at least by the standards of the various naming
# conventions used in R. Dates and datetimes are converted to POSIXct class.
# Some extra URL data included in the API is also stripped out.
#
# @param df The tibble to tidy
# @param tidy_style The style to tidy variable names to.


parlitools_tidy <- function(df, tidy_style) {
  names(df) <- gsub("\\.", "_", names(df))

  names(df) <- gsub("([[:lower:]])([[:upper:]])", "\\1_\\2", names(df))

  names(df) <- gsub("__", "_", names(df))

  names(df) <- gsub("^_", "", names(df))

  names(df) <- tolower(names(df))

  names(df)[names(df) == "df_about"] <- "about"

  names(df)[names(df) == "df_value"] <- "value"

  names(df) <- gsub("@", "", names(df))

  names(df) <- gsub("#", "", names(df))

  names(df) <- gsub("\\.\\.", "\\.", names(df))

  names(df) <- gsub("^Members\\.Member\\.", "", names(df))

  names(df) <- gsub("^BasicDetails\\.", "", names(df))

  names(df) <- gsub("^BiographyEntries\\.", "", names(df))

  names(df) <- gsub("^Committees\\.", "", names(df))

  names(df) <- gsub("^Addresses\\.", "", names(df))

  names(df) <- gsub("^Constituencies\\.", "", names(df))

  names(df) <- gsub("^ElectionsContested\\.", "", names(df))

  names(df) <- gsub("^Edfperiences\\.", "", names(df))

  names(df) <- gsub("^GovernmentPosts\\.", "", names(df))

  names(df) <- gsub("^Honours\\.", "", names(df))

  names(df) <- gsub("^HouseMemberships\\.", "", names(df))

  names(df) <- gsub("^Statuses\\.", "", names(df))

  names(df) <- gsub("^Staff\\.", "", names(df))

  names(df) <- gsub("^Interests\\.Category\\.Interest\\.",
                    "Interest\\.", names(df))

  names(df) <- gsub("^Interests\\.Category\\.", "Interest\\.", names(df))

  names(df) <- gsub("^MaidenSpeeches\\.", "", names(df))

  names(df) <- gsub("^OppositionPosts\\.", "", names(df))

  names(df) <- gsub("^Parties\\.", "", names(df))

  names(df) <- gsub("^PreferredNames\\.", "", names(df))

  names(df) <- gsub("^ParliamentaryPosts\\.", "", names(df))

  names(df) <- gsub("^OtherParliaments\\.", "", names(df))

  names(df) <- gsub("^ParliamentaryPosts\\.", "", names(df))

  names(df) <- gsub("^Post.PostHolders.PostHolder.Member",
                    "PostHolder", names(df))

  names(df) <- gsub("^Post\\.PostHolders\\.", "", names(df))

  names(df) <- gsub("xsi:nil", "nil", names(df))

  names(df) <- gsub("xmlns:xsi", "label", names(df))

  names(df) <- gsub("\\.", "_", names(df))

  names(df) <- gsub("([[:lower:]])([[:upper:]])", "\\1_\\2", names(df))

  names(df) <- gsub("__", "_", names(df))
  
  names(df) <- gsub(" ", "_", names(df))

  names(df) <- tolower(names(df))

  names(df)[names(df) == "df_house"] <- "house"

  if (tidy_style == "camelCase") {
    names(df) <- gsub("(^|[^[:alnum:]])([[:alnum:]])", "\\U\\2",
                      names(df), perl = TRUE)

    substr(names(df), 1, 1) <- tolower(substr(names(df), 1, 1))
  } else if (tidy_style == "period.case") {
    names(df) <- gsub("_", ".", names(df))
  }

  df
}
