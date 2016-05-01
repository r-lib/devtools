context("build")

test_that("source builds return correct filenames", {
  path <- devtools::build("testNamespace", path=tempdir(),
                          quiet=TRUE)
  expect_true(file.exists(path))
})

test_that("binary builds return correct filenames", {
  path <- devtools::build("testNamespace", binary=TRUE, path=tempdir(),
                          quiet=TRUE)
  expect_true(file.exists(path))
})
