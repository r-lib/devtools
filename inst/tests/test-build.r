context("Building")

test_that("Message about extra files in package", {

  expect_message(buildfile <- build("build-extrafile"),
    regexp = "found.*an_extra_file")

  unlink(buildfile)
})
