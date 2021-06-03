test_that("uninstall() unloads and removes from library", {
  withr::local_temp_libpaths()

  # Install package
  install(test_path("testHelp"), quiet = TRUE)
  expect_true(require(testHelp, quietly = TRUE))
  expect_true("testHelp" %in% loaded_packages()$package)

  # Uninstall package
  uninstall(test_path("testHelp"), quiet = TRUE)
  expect_false("testHelp" %in% loaded_packages()$package)
  suppressWarnings(expect_false(require(testHelp, quietly = TRUE)))
})
