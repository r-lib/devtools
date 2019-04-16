context("Test")

test_that("Package can be tested with testthat not on search path", {
  testthat_pos <- which(search() == "package:testthat")
  if (length(testthat_pos) > 0) {
    testthat_env <- detach(pos = testthat_pos)
    on.exit(attach(testthat_env, testthat_pos), add = TRUE)
  }

  test("testTest", reporter = "stop")
  expect_true(TRUE)
  test("testTestWithDepends", reporter = "stop")
  expect_true(TRUE)
})

test_that("Filtering works with devtools::test", {
  test("testTest", filter = "dummy", reporter = "stop")
  expect_true(TRUE)
})

test_that("devtools::test_file works", {
  expect_error(test_file("testTest/DESCRIPTION"), "are not valid R or src files")
  test_file("testTest/tests/testthat/test-dummy.R", pkg = "testTest", reporter = "stop")
  test_file("testTest/R/dummy.R", pkg = "testTest", reporter = "stop")
  expect_true(TRUE)
})

test_that("TESTTHAT_PKG environment varaible is set", {
  test("testTest", filter = "envvar", reporter = "stop")
  expect_true(TRUE)
})
