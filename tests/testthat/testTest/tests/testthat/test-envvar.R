context("envvar")

test_that("TESTTHAT_PKG environment variable is set", {
  expect_equal(Sys.getenv("TESTTHAT_PKG"), "testTest")
})
