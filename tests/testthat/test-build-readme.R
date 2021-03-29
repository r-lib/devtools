test_that("Package readme in root directory can be built ", {
  skip_on_cran()

  pkg_path <- create_local_package()

  # errors if no readme found
  expect_error(
    build_readme(pkg_path),
    "Can't find a 'README.Rmd'"
  )

  suppressMessages(use_readme_rmd())

  suppressMessages(build_readme(pkg_path))

  expect_true(file_exists(path(pkg_path, "README.md")))
  expect_false(file_exists(path(pkg_path, "README.html")))
})

test_that("Package readme in inst/ can be built ", {
  skip_on_cran()

  pkg_path <- create_local_package()
  suppressMessages(use_readme_rmd())
  dir_create(pkg_path, "inst")
  file_copy(
    path(pkg_path, "README.Rmd"),
    path(pkg_path, "inst", "README.Rmd")
  )

  # errors if both a root readme and inst readme found
  expect_error(
    build_readme(pkg_path),
    "Can't have both"
  )

  file_delete(path(pkg_path, "README.Rmd"))

  suppressMessages(build_readme(pkg_path))

  expect_true(file_exists(path(pkg_path, "inst", "README.md")))
  expect_false(file_exists(path(pkg_path, "README.Rmd")))
  expect_false(file_exists(path(pkg_path, "README.md")))
  expect_false(file_exists(path(pkg_path, "inst", "README.html")))
})
