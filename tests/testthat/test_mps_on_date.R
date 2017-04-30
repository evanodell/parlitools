library(parlitools)
context("mps_on_date")

test_that("mps_on_date return expected format", {
  
  skip_on_cran()
  
  xmpon <- mps_on_date("2017-04-30")
  expect_length(xmpon, 39)
  expect_type(xmpon, "list")
  expect_true(tibble::is_tibble(xmpon))
  expect_true(nrow(xmpon)==649)
  
  xmpon2 <- mps_on_date("1990-04-30")
  expect_length(xmpon, 39)
  expect_type(xmpon, "list")
  expect_true(tibble::is_tibble(xmpon))
  expect_true(nrow(xmpon)==649)
  
})
