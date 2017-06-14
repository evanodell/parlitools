library(parlitools)
context("current_mps")

test_that("current_mps return expected format", {
    
  skip_on_cran()
  
  #Too dynamic a function for proper testing

  xcm <- current_mps()
  expect_length(xcm, 31)
  expect_type(xcm, "list")
  expect_true(tibble::is_tibble(xcm))
    
})
