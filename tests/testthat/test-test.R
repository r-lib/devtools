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
  out <- test_test_active_file(test_path(
    "testTest/tests/testthat/test-dummy.R"
  ))
  expect_equal(length(out), 1)
})

test_that("TESTTHAT_PKG environment variable is set", {
  withr::local_envvar("TESTTHAT_PKG" = "incorrect")

  test_test(
    test_path("testTest"),
    filter = "envvar",
    stop_on_failure = TRUE
  )
  test_test_active_file(
    test_path("testTest/tests/testthat/test-envvar.R"),
    stop_on_failure = TRUE
  )

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

test_that("test_coverage_active_file() computes coverage", {
  skip_on_covr()
  pkg <- local_package_create()
  writeLines(
    c(
      "add <- function(x, y) x + y",
      "multiply <- function(x, y) x * y",
      "compute <- function(x) {",
      "  x + 1",
      "  x + 2",
      "}"
    ),
    file.path(pkg, "R", "math.R")
  )
  dir_create(file.path(pkg, "tests", "testthat"))
  writeLines(
    c(
      "test_that('add works', {",
      "  expect_equal(add(1, 2), 3)",
      "})"
    ),
    file.path(pkg, "tests", "testthat", "test-math.R")
  )

  expect_snapshot(test_coverage_active_file(
    file.path(pkg, "R", "math.R"),
    report = "zero"
  ))
})

test_that("test_coverage_active_file() reports full coverage", {
  skip_on_covr()
  pkg <- local_package_create()
  writeLines(
    "add <- function(x, y) x + y",
    file.path(pkg, "R", "math.R")
  )
  dir_create(file.path(pkg, "tests", "testthat"))
  writeLines(
    c(
      "test_that('add works', {",
      "  expect_equal(add(1, 2), 3)",
      "})"
    ),
    file.path(pkg, "tests", "testthat", "test-math.R")
  )

  expect_snapshot(test_coverage_active_file(
    file.path(pkg, "R", "math.R"),
    report = "zero"
  ))
})

test_that("report_default() does its job", {
  withr::local_options(rlang_interactive = FALSE)
  expect_equal(report_default(NULL), "zero")

  withr::local_options(rlang_interactive = TRUE)
  if (!is_llm()) {
    expect_equal(report_default(NULL), "html")
  }

  withr::local_envvar(AGENT = 1)
  expect_equal(report_default(NULL), "zero")

  expect_equal(report_default("silent"), "silent")
  expect_equal(report_default("zero"), "zero")
  expect_equal(report_default("html"), "html")
  expect_snapshot(report_default("bad"), error = TRUE)
})
