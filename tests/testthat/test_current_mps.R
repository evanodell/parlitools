library(parlitools)
context("current_mps")

test_that("current_mps return expected format", {
    
  skip_on_cran()
  
  xcm <- current_mps()
  #expect_length(xcm, 29)
  expect_type(xcm, "list")
  expect_true(tibble::is_tibble(xcm))
    
})
