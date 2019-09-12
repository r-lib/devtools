test_that("reload works", {
  withr::local_temp_libpaths()

  pkg <- as.package(test_path("testTest"))

  install(pkg, quiet = TRUE)
  on.exit(unload(pkg$package), add = TRUE)

  expect_false(is_loaded(pkg))

  # Do nothing if the package is not loaded
  expect_error(reload(pkg), NA)
  expect_false(is_loaded(pkg))

  # Reload if loaded
  requireNamespace(pkg$package, quietly = TRUE)
  expect_true(is_loaded(pkg))
  reload(pkg)
  expect_true(is_loaded(pkg))

  # Re-attach if attached
  unload(pkg$package, quiet = TRUE)
  library(pkg$package, character.only = TRUE, quietly = TRUE)
  expect_true(is_loaded(pkg))
  expect_true(is_attached(pkg))
  reload(pkg)
  expect_true(is_loaded(pkg))
  expect_true(is_attached(pkg))
})
