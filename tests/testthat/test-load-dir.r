context("Working directory when loading")

test_that("Package root is working directory when loading", {
  expect_message(load_all("testLoadDir"), "[|].*/testLoadDir[|]")
})
