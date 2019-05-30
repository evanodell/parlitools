context("test-council_seats")

test_that("council_seats works", {
  skip_on_cran()
  
  summary <- council_seats(councillors = FALSE)
  expect_true(tibble::is_tibble(summary))
  expect_length(summary, 18)


})
