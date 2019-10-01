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

test_that("stop_on_failure set to FALSE if not provided", {
  expect_output(test("testTestWithFailure", filter = "fail"), "Broken")
})

test_that("stop_on_failure passed on if provided", {
  expect_output(test("testTestWithFailure", filter = "fail", stop_on_failure = FALSE), "Broken")
  expect_error(test("testTestWithFailure", filter = "fail", stop_on_failure = TRUE))
})

test_that("stop_on_warning passed on if provided", {
  expect_output(test("testTestWithFailure", filter = "warn", stop_on_warning = FALSE), "Beware!")
  expect_error(test("testTestWithFailure", filter = "warn", stop_on_warning = TRUE))
})
