test_that("can build README.Rmd in root directory", {
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

test_that("can build README.Rmd in inst/", {
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

test_that("can build README.qmd in root directory", {
  skip_on_cran()
  skip_if_not_installed("quarto")
  skip_if_not(quarto::quarto_available(), "quarto cli not available")

  pkg <- local_package_create()
  # TODO: use usethis::use_readme_qmd() once it's in a usethis release
  # https://github.com/r-lib/usethis/pull/2219
  writeLines(
    c(
      "---",
      "format: gfm",
      "---",
      "",
      "# testpkg",
      "",
      "This is a test package."
    ),
    path(pkg, "README.qmd")
  )

  build_readme(pkg, quiet = TRUE)
  expect_true(file_exists(path(pkg, "README.md")))
})

test_that("can build README.qmd in inst/", {
  skip_on_cran()
  skip_if_not_installed("quarto")
  skip_if_not(quarto::quarto_available(), "quarto cli not available")

  pkg <- local_package_create()
  # TODO: use usethis::use_readme_qmd() once it's in a usethis release
  # https://github.com/r-lib/usethis/pull/2219
  dir_create(pkg, "inst")
  writeLines(
    c(
      "---",
      "format: gfm",
      "---",
      "",
      "# testpkg",
      "",
      "This is a test package."
    ),
    path(pkg, "inst", "README.qmd")
  )

  build_readme(pkg, quiet = TRUE)
  expect_true(file_exists(path(pkg, "inst", "README.md")))
  expect_false(file_exists(path(pkg, "README.qmd")))
  expect_false(file_exists(path(pkg, "README.md")))
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

test_that("errors if both README.qmd and README.Rmd exist", {
  pkg <- local_package_create()
  file_create(path(pkg, "README.Rmd"))
  file_create(path(pkg, "README.qmd"))
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
