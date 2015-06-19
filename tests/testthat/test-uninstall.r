context("Uninstall")

test_that("uninstall() unloads and removes from library", {

  with_temp_libpaths({
    # Install package
    install("testHelp", quiet = TRUE)
    expect_true(require(testHelp))
    expect_true("testHelp" %in% loaded_packages()$package)

    # Uninstall package
    uninstall("testHelp", quiet = TRUE)
    expect_false("testHelp" %in% loaded_packages()$package)
    expect_false(require(testHelp, quiet = TRUE))
  })

})
