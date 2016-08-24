context("Load: collate")

test_that("If collate absent, load in alphabetical order", {
  load_all("testCollateAbsent")

  expect_equal(a, 3)

  unload("testCollateAbsent")
})

test_that("Warned about files missing from collate, but they're still loaded", {
  expect_message(load_all("testCollateMissing"), "a.r")

  expect_equal(a, 1)
  expect_equal(b, 2)

  unload("testCollateMissing")
})

test_that("Extra files in collate don't error, but warn", {
  expect_message(load_all("testCollateExtra"), "b.r")

  expect_equal(a, 1)

  unload("testCollateExtra")
})

temp_copy_pkg <- function(pkg) {
  file.copy(normalizePath(pkg), tempdir(), recursive = TRUE)
  normalizePath(file.path(tempdir(), pkg))
}

test_that("DESCRIPTION Collate field, with latest @includes, is recognised by load_all", {
  # Make a temporary copy of the package for this test,
  # since update_collate (in load_all) may have permanent side effects,
  # namely changing the collate field in the DESCRIPTION file
  test_pkg <- temp_copy_pkg('testCollateOrder')
  on.exit(unlink(test_pkg, recursive = TRUE))

  expect_output(
    expect_message(load_all(test_pkg), "Loading testCollateOrder"),
    "Updating collate directive"
  )

  expect_equal(a, 1) #even though b.r set it to 2

  unload(test_pkg)
})
