context("Documentation checks")

test_that("invalid DESCRIPTION gives warning", {
  expect_message(load_all("testInvalidDescription"), "Invalid DESCRIPTION")
  expect_message(load_all("testInvalidDescription"), "fields missing")

  unload("testInvalidDescription")
})


test_that("Parse DESCRIPTION file", {
  pkg <- as.package("testNamespace")

  expect_identical("0.1", pkg$version)
  expect_identical("testNamespace", pkg$package)
})
