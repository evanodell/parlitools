context("test-council_seats")

test_that("council_seats works", {
  summary <- council_seats(councillors = FALSE)
  expect_true(tibble::is.tibble(summary))
  expect_true(nrow(summary)==423)
  
  
})
