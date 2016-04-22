context("Uninstall")

test_that("uninstall() unloads and removes from library", {

  # Make a temp lib directory to install test package into
  old_libpaths <- .libPaths()
  tmp_libpath = file.path(tempdir(), "devtools_test")
  if (!dir.exists(tmp_libpath)) dir.create(tmp_libpath)
  .libPaths(c(tmp_libpath, .libPaths()))

  # Reset the libpath on exit
  on.exit(.libPaths(old_libpaths), add = TRUE)

  # Install package
  install("testHelp", quiet = TRUE)
  expect_true(require(testHelp))
  expect_true("testHelp" %in% loaded_packages()$package)

  # Uninstall package
  uninstall("testHelp", quiet = TRUE)
  expect_false("testHelp" %in% loaded_packages()$package)
  expect_warning(expect_false(require(testHelp, quietly = TRUE)),
                 paste0("there is no package called ", sQuote("testHelp") ))
})
