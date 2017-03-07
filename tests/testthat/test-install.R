context("Install")

test_that("install(dependencies = FALSE) doesn't query available_packages()", {
  withr::with_temp_libpaths(
    with_mock(
      `devtools::available_packages` = function(...) stop("available_packages() called"),
      expect_error(install("testNamespace", quiet = TRUE), "available_packages"),
      expect_error(install("testNamespace", quiet = TRUE, dependencies = FALSE), NA)
    )
  )
})
