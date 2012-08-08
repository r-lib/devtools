
test_that("Warned about dependency versions", {
  # Should give a warning about grid version
  expect_warning(load_all("depend-version"), "needs grid >=")
  unload("depend-version")

  # TODO: Add check for NOT giving a warning about compiler version
  # Not possible with testthat?
})


test_that("Error on missing dependencies", {
  # Should give a warning about grid version
  expect_error(load_all("depend-missing"), "missingpackage not available")
})
