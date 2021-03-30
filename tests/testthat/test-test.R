test_test <- function(...) {
  suppressMessages(test(..., reporter = "silent"))
}
test_test_active_file <- function(...) {
  suppressMessages(test_active_file(..., reporter = "silent"))
}

test_that("Package can be tested with testthat not on search path", {
  pkg1 <- test_path("testTest")
  pkg2 <- test_path("testTestWithDepends")

  testthat_pos <- which(search() == "package:testthat")
  if (length(testthat_pos) > 0) {
    testthat_env <- detach(pos = testthat_pos)
    on.exit(attach(testthat_env, testthat_pos), add = TRUE)
  }

  test_test(pkg1)
  expect_true(TRUE)
  test_test(pkg2)
  expect_true(TRUE)
})

test_that("Filtering works with devtools::test", {
  out <- test_test(test_path("testTest"), filter = "dummy")
  expect_equal(length(out), 1)
})

test_that("devtools::test_active_file works", {
  out <- test_test_active_file(test_path("testTest/tests/testthat/test-dummy.R"))
  expect_equal(length(out), 1)
})

test_that("TESTTHAT_PKG environment varaible is set", {
  test_test(test_path("testTest"), filter = "envvar")
  expect_true(TRUE)
})

test_that("stop_on_failure defaults to FALSE", {
  expect_error(
    test_test(test_path("testTestWithFailure")),
    NA
  )
  expect_error(
    test_test(test_path("testTestWithFailure"), stop_on_failure = TRUE),
    "Test failures"
  )
})
