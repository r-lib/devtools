test_that("can build README in root directory", {
  skip_on_cran()

  pkg <- local_package_create()
  usethis::ui_silence(
    usethis::with_project(
      pkg,
      use_readme_rmd(open = FALSE)
    )
  )

  build_readme(pkg, quiet = TRUE)
  expect_true(file_exists(path(pkg, "README.md")))
  expect_false(file_exists(path(pkg, "README.html")))
})

test_that("can build README in inst/", {
  skip_on_cran()

  pkg <- local_package_create()
  usethis::ui_silence(
    usethis::with_project(
      pkg,
      use_readme_rmd(open = FALSE)
    )
  )
  dir_create(pkg, "inst")
  file_move(
    path(pkg, "README.Rmd"),
    path(pkg, "inst", "README.Rmd")
  )

  build_readme(pkg, quiet = TRUE)
  expect_true(file_exists(path(pkg, "inst", "README.md")))
  expect_false(file_exists(path(pkg, "README.Rmd")))
  expect_false(file_exists(path(pkg, "README.md")))
  expect_false(file_exists(path(pkg, "inst", "README.html")))
})

test_that("useful errors if too few or too many", {
  pkg <- local_package_create()
  expect_snapshot(build_readme(pkg), error = TRUE)

  usethis::ui_silence(
    usethis::with_project(
      pkg,
      use_readme_rmd(open = FALSE)
    )
  )
  dir_create(pkg, "inst")
  file_copy(path(pkg, "README.Rmd"), path(pkg, "inst", "README.Rmd"))
  expect_snapshot(build_readme(pkg), error = TRUE)
})

test_that("don't error for README in another directory", {
  skip_on_cran()

  pkg <- local_package_create()
  usethis::ui_silence(
    usethis::with_project(
      pkg,
      use_readme_rmd(open = FALSE)
    )
  )
  dir_create(pkg, "data-raw")
  file_create(pkg, "data-raw", "README.md")

  expect_no_error(build_readme(pkg, quiet = TRUE))
})

test_that("build_rmd() is deprecated", {
  skip_on_cran()

  pkg <- local_package_create()
  usethis::ui_silence(
    usethis::with_project(
      pkg,
      use_readme_rmd(open = FALSE)
    )
  )

  withr::local_options(lifecycle_verbosity = "warning")
  # it's hard (impossible?) to silence pak (cli, really) so that's what the
  # suppressMessages() is for
  expect_snapshot(suppressMessages(build_rmd(
    "README.Rmd",
    path = pkg,
    quiet = TRUE
  )))
})
