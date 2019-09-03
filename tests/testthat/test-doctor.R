test_that("check_for_rstudio_updates", {
  # returns nothing rstudio not available
  expect_null(check_for_rstudio_updates("mac", "1.0.0", FALSE))

  # returns nothing if the version is ahead of the current version
  expect_null(check_for_rstudio_updates("mac", "1000.0.0", TRUE))

  # returns something if the version is behind of the current version
  res <- check_for_rstudio_updates("mac", "0.0.1", TRUE)
  expect_match(res, "RStudio is out of date")
  expect_match(res, "Download at")
})
