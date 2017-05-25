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
