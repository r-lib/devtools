context("Checks")

test_that("Message about extra files in package", {

  built_file <- build("testCheckExtrafile", quiet = TRUE)
  expect_message(check_devtools("testCheckExtrafile/", built_file),
    regexp = "found.*an_extra_file")

  unlink(built_file)
})
