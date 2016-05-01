context("Check")

test_that("sucessful check doesn't trigger error", {
  skip_on_cran()
  results <- check("testTest", quiet = TRUE)

  expect_error(signal_check_results(results), NA)
  expect_equal(
    summarise_check_results(results),
    "0 errors | 0 warnings | 0 notes",
    fixed = TRUE
  )
})

test_that("check with NOTES captured", {
  skip_on_cran()

  results <- parse_check_results("check-results-note.log")

  expect_error(signal_check_results(results), NA)
  expect_error(
    signal_check_results(results, "note"),
    "0 errors | 0 warnings | 2 notes",
    fixed = TRUE
  )
})
