context("Checks")

test_that("Message about extra files in package", {

  built_file <- build("check-extrafile")
  expect_message(check_devtools("check-extrafile/", built_file),
    regexp = "found.*an_extra_file")

  unlink(built_file)
})
