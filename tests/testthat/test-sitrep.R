test_that("check_for_rstudio_updates", {
  skip_if_offline()
  skip_on_cran()

  # returns nothing rstudio not available
  expect_null(check_for_rstudio_updates("mac", "1.0.0", FALSE))

  # returns nothing if the version is ahead of the current version
  expect_null(check_for_rstudio_updates("mac", "2030.12.0+123", TRUE))

  # returns something if the version is behind the current version
  local_edition(3)
  scrub_current_version <- function(message) {
    sub("(?<=^RStudio )[0-9\\.\\+]+", "{VERSION}", message, perl = TRUE)
  }

  # truly ancient
  expect_snapshot(
    writeLines(check_for_rstudio_updates("mac", "0.0.1", TRUE)),
    transform = scrub_current_version
  )

  # Juliet Rose, does not have long_version, last before numbering changed
  expect_snapshot(
    writeLines(check_for_rstudio_updates("mac", "1.4.1717", TRUE)),
    transform = scrub_current_version
  )

  # new scheme, introduced 2021-08
  # YYYY.MM.<patch>[-(daily|preview)]+<build number>[.pro<pro suffix>]
  # YYY.MM is th expected date of release for dailies and previews

  # a superceded preview
  expect_snapshot(
    writeLines(check_for_rstudio_updates("mac", "2021.09.1+372", TRUE)),
    transform = scrub_current_version
  )

  # a superceded daily
  expect_snapshot(
    writeLines(check_for_rstudio_updates("mac", "2021.09.0-daily+328", TRUE)),
    transform = scrub_current_version
  )
})
