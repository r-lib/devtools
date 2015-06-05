context("Loading")

test_that("Package root is working directory when loading", {
  expect_message(load_all("testLoadDir"), "[|].*/testLoadDir[|]")
})

test_that("Loading a package subdirectory throws an error", {
  expect_error(load_all(file.path("testLoadDir", "R")),
               "does not look like a package")
})
