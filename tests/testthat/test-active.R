test_that("find_active_file() gives useful error if no RStudio", {
  expect_snapshot(find_active_file(), error = TRUE)
})

test_that("fails if can't find tests", {
  dir <- local_package_create()
  withr::local_dir(dir)

  expect_snapshot(error = TRUE, {
    find_test_file("R/foo.blah")
    find_test_file("R/foo.R")
  })
})

test_that("find_test_file() works with snapshot files", {
  dir <- local_package_create()
  withr::local_dir(dir)
  dir_create("tests/testthat/_snaps")
  file_create("tests/testthat/test-foo.R")
  file_create("tests/testthat/_snaps/foo.md")

  path <- find_test_file("tests/testthat/_snaps/foo.md")
  expect_equal(path_file(path), "test-foo.R")
})

test_that("find_test_file() works with snapshot variant files", {
  dir <- local_package_create()

  withr::local_dir(dir)
  dir_create("tests/testthat/_snaps/variant")
  file_create("tests/testthat/test-foo.R")
  file_create("tests/testthat/_snaps/variant/foo.md")

  path <- find_test_file("tests/testthat/_snaps/variant/foo.md")
  expect_equal(path_file(path), "test-foo.R")
})

test_that("can determine file type", {
  expect_equal(test_file_type("R/foo.R"), "R")
  expect_equal(test_file_type("R/foo.c"), NA_character_)

  expect_equal(test_file_type("src/foo.c"), "src")
  expect_equal(test_file_type("src/foo.R"), NA_character_)

  expect_equal(test_file_type("tests/testthat/test-foo.R"), "test")
  expect_equal(test_file_type("tests/testthat/test-foo.c"), NA_character_)
  expect_equal(test_file_type("tests/testthat/foo.R"), NA_character_)

  expect_equal(test_file_type("tests/testthat/_snaps/foo.md"), "snap")
  expect_equal(test_file_type("tests/testthat/_snaps/variant/foo.md"), "snap")
  expect_equal(test_file_type("tests/testthat/_snaps/foo.R"), NA_character_)

  expect_equal(test_file_type("DESCRIPTION"), NA_character_)
})
