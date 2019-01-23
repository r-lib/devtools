context("envvar")

test_that("TESTTHAT_PKG environment varaible is set", {
  expect_equal(Sys.getenv("TESTTHAT_PKG"), "devtools")
})
