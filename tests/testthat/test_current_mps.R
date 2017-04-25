library(parlitools)
context("current_mps")

test_that("current_mps return expected format", {
    
  skip_on_cran()

  x <- current_mps()
  expect_length(x, 31)
  expect_type(x, "list")
  expect_true(tibble::is_tibble(x))
    
})
