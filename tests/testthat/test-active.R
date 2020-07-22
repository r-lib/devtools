test_that("fails if can't find tests", {
  expect_error(find_test_file("DESCRIPTION"), "find tests")
  expect_error(find_test_file("R/foo.R"), "No test files found")
})

test_that("can determine file type", {
  expect_equal(test_file_type("R/foo.R"), "R")
  expect_equal(test_file_type("R/foo.c"), NA_character_)

  expect_equal(test_file_type("src/foo.c"), "src")
  expect_equal(test_file_type("src/foo.R"), NA_character_)

  expect_equal(test_file_type("tests/testthat/test-foo.R"), "test")
  expect_equal(test_file_type("tests/testthat/test-foo.c"), NA_character_)
  expect_equal(test_file_type("tests/testthat/foo.R"), NA_character_)

  expect_equal(test_file_type("DESCRIPTION"), NA_character_)
})
