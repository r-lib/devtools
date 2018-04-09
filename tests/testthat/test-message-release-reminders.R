context("test-release-reminders.R")

test_that("no reminder if nothing to be reminded of", {
  expect_silent(message_release_reminders("testMinimalPkg"))
})

test_that("pkgdown reminder if pkgdown website", {
  expect_message(message_release_reminders("testPkgdown"),
                 "Don't forget to update the pkgdown website of your package")
})
