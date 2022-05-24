test_that("can build README in root directory", {
  skip_on_cran()

  pkg <- local_package_create()
  suppressMessages(usethis::with_project(pkg, use_readme_rmd()))

  suppressMessages(build_readme(pkg))
  expect_true(file_exists(path(pkg, "README.md")))
  expect_false(file_exists(path(pkg, "README.html")))
})

test_that("can build README in inst/", {
  skip_on_cran()

  pkg <- local_package_create()
  suppressMessages(usethis::with_project(pkg, use_readme_rmd()))
  dir_create(pkg, "inst")
  file_move(
    path(pkg, "README.Rmd"),
    path(pkg, "inst", "README.Rmd")
  )

  suppressMessages(build_readme(pkg))
  expect_true(file_exists(path(pkg, "inst", "README.md")))
  expect_false(file_exists(path(pkg, "README.Rmd")))
  expect_false(file_exists(path(pkg, "README.md")))
  expect_false(file_exists(path(pkg, "inst", "README.html")))
})

test_that("useful errors if too few or too many", {
  pkg <- local_package_create()
  expect_snapshot(build_readme(pkg), error = TRUE)

  suppressMessages(usethis::with_project(pkg, use_readme_rmd()))
  dir_create(pkg, "inst")
  file_copy(path(pkg, "README.Rmd"), path(pkg, "inst", "README.Rmd"))
  expect_snapshot(build_readme(pkg), error = TRUE)
})
