test_that("check_for_rstudio_updates", {
  skip_if_offline()
  skip_on_cran()

  # returns nothing rstudio not available
  expect_null(check_for_rstudio_updates("mac", "1.0.0", FALSE))

  # returns nothing if the version is ahead of the current version
  # THIS NEEDS AN UPDATE
  # expect_null(check_for_rstudio_updates("mac", "1000.0.0", TRUE))

  # returns something if the version is behind the current version
  res <- check_for_rstudio_updates("mac", "0.0.1", TRUE)
  expect_match(res, "RStudio .* is now available")
  expect_match(res, "Download at")
})
