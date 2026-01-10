test_that("can build README in root directory (Rmd)", {
  skip_on_cran()

  pkg <- local_package_create()
  suppressMessages(usethis::with_project(pkg, use_readme_rmd()))

  suppressMessages(build_readme(pkg))
  expect_true(file_exists(path(pkg, "README.md")))
  expect_false(file_exists(path(pkg, "README.html")))
})

test_that("can build README in inst/ (Rmd)", {
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

test_that("can build README in root directory (qmd)", {
  skip_on_cran()

  pkg <- local_package_create()
  suppressMessages(usethis::with_project(pkg, use_readme_qmd()))

  suppressMessages(build_readme(pkg))
  expect_true(file_exists(path(pkg, "README.md")))
  expect_false(file_exists(path(pkg, "README.html")))
})

test_that("can build README in inst/ (qmd)", {
  skip_on_cran()

  pkg <- local_package_create()
  suppressMessages(usethis::with_project(pkg, use_readme_qmd()))
  dir_create(pkg, "inst")
  file_move(
    path(pkg, "README.qmd"),
    path(pkg, "inst", "README.qmd")
  )

  suppressMessages(build_readme(pkg))
  expect_true(file_exists(path(pkg, "inst", "README.md")))
  expect_false(file_exists(path(pkg, "README.qmd")))
  expect_false(file_exists(path(pkg, "README.md")))
  expect_false(file_exists(path(pkg, "inst", "README.html")))
})

test_that("useful errors if too few or too many (Rmd)", {
  skip_on_cran()

  pkg <- local_package_create()
  expect_snapshot(build_readme(pkg), error = TRUE)

  suppressMessages(usethis::with_project(pkg, use_readme_rmd()))
  dir_create(pkg, "inst")
  file_copy(path(pkg, "README.Rmd"), path(pkg, "inst", "README.Rmd"))
  expect_snapshot(build_readme(pkg), error = TRUE)
})

test_that("useful errors if too few or too many (qmd)", {
  skip_on_cran()

  pkg <- local_package_create()
  expect_snapshot(build_readme(pkg), error = TRUE)

  suppressMessages(usethis::with_project(pkg, use_readme_qmd()))
  dir_create(pkg, "inst")
  file_copy(path(pkg, "README.qmd"), path(pkg, "inst", "README.qmd"))
  expect_snapshot(build_readme(pkg), error = TRUE)
})

test_that("useful errors if too many--mixed Quarto and Rmd", {
  skip_on_cran()

  pkg <- local_package_create()

  suppressMessages(usethis::with_project(pkg, use_readme_rmd(open = FALSE)))

  file_copy(path(pkg, "README.Rmd"), path(pkg, "README.qmd"))

  expect_snapshot(build_readme(pkg), error = TRUE)
})

test_that("don't error for README in another directory (Rmd)", {
  skip_on_cran()

  pkg <- local_package_create()
  suppressMessages(usethis::with_project(pkg, use_readme_rmd(open = FALSE)))
  dir_create(pkg, "data-raw")
  file_create(pkg, "data-raw", "README.md")

  expect_no_error(suppressMessages(build_readme(pkg)))
})

test_that("don't error for README in another directory (qmd)", {
  skip_on_cran()

  pkg <- local_package_create()
  suppressMessages(usethis::with_project(pkg, use_readme_qmd(open = FALSE)))
  dir_create(pkg, "data-raw")
  file_create(pkg, "data-raw", "README.md")

  expect_no_error(suppressMessages(build_readme(pkg)))
})
