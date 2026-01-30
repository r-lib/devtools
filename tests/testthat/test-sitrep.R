test_that("check_for_rstudio_updates", {
  skip_if_offline()
  skip_on_cran()
  withr::local_envvar(POSITRON = "")

  # the IDE ends up calling this with `os = "mac"` on macOS, but we would send
  # "darwin" in that case, so I test with "darwin"
  # also mix in some "windows"

  # returns nothing rstudio not available
  expect_null(check_for_rstudio_updates("darwin", "1.0.0", FALSE))

  # returns nothing if the version is ahead of the current version
  expect_null(check_for_rstudio_updates("windows", "2030.12.0+123", TRUE))

  # returns something if ...
  local_edition(3)
  scrub_current_version <- function(message) {
    sub("(?<=^RStudio )[0-9\\.\\+]+", "{VERSION}", message, perl = TRUE)
  }

  # version is not understood by the service
  expect_snapshot(
    writeLines(check_for_rstudio_updates("windows", "haha-no-wut", TRUE))
  )

  # version is behind the current version

  # truly ancient
  expect_snapshot(
    writeLines(check_for_rstudio_updates("darwin", "0.0.1", TRUE)),
    transform = scrub_current_version
  )

  # Juliet Rose, does not have long_version, last before numbering changed
  expect_snapshot(
    writeLines(check_for_rstudio_updates("windows", "1.4.1717", TRUE)),
    transform = scrub_current_version
  )

  # new scheme, introduced 2021-08
  # YYYY.MM.<patch>[-(daily|preview)]+<build number>[.pro<pro suffix>]
  # YYY.MM is th expected date of release for dailies and previews

  # an out-of-date preview
  expect_snapshot(
    writeLines(check_for_rstudio_updates("darwin", "2021.09.1+372", TRUE)),
    transform = scrub_current_version
  )

  # an out-of-date daily
  expect_snapshot(
    writeLines(check_for_rstudio_updates(
      "windows",
      "2021.09.0-daily+328",
      TRUE
    )),
    transform = scrub_current_version
  )
})
