context("DESCRIPTION checks")

test_that("Parse DESCRIPTION file", {
  pkg <- as.package("testNamespace")

  expect_identical("0.1", pkg$version)
  expect_identical("testNamespace", pkg$package)
})
