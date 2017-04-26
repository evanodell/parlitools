library(parlitools)
context("west_hex_map")

test_that("west_hex_map return expected format", {
  
  skip_on_cran()
  
  map <- parlitools::west_hex_map
  expect_length(map, 8)
  expect_type(map, "list")
  expect_true(sf::st_is(map$geometry[[2]], "POLYGON"))
  
})
