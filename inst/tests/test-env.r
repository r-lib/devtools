context("Environment setup")

test_that("system.file overriden", {
  load_all("basic")
  
  browser()
  expect_that(home(), equals(normalizePath("basic")))
  
  
  detach("package:basic")
})