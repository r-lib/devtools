context("Documentation checks")

test_that("invalid DESCRIPTION gives warning", {
  expect_message(load_all("invalid-description"), 
    c("invalid DESCRIPTION", "fields missing"))
})


test_that("Parse DESCRIPTION file", {
  pkg <- as.package("namespace")

  expect_identical("0.1", pkg$version)
  expect_identical("namespace", pkg$package)
})
