library(parlitools)
context("mps_on_date")

test_that("mps_on_date return expected format", {
  
  skip_on_cran()
  
  xmpon <- mps_on_date("2017-04-30")
  expect_length(xmpon, 38)
  expect_type(xmpon, "list")
  expect_true(tibble::is_tibble(xmpon))
  expect_true(nrow(xmpon)==649)
  
  xmpon2 <- mps_on_date(date1="1990-04-30", date2="2015-05-10")
  expect_length(xmpon2, 21)
  expect_type(xmpon2, "list")
  expect_true(tibble::is_tibble(xmpon2))
  expect_true(nrow(xmpon2)==1730)
  
  xmpon3 <- mps_on_date(date2="1990-04-30", date1="2015-05-10", tidy=FALSE)
  expect_length(xmpon3, 21)
  expect_type(xmpon3, "list")
  expect_true(tibble::is_tibble(xmpon3))
  expect_true(nrow(xmpon3)==1730)
  
})
