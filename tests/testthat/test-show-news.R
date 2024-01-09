test_that("can read NEWS.md in root directory", {
  skip_on_cran()

  pkg <- local_package_create()
  write(
    "# test 0.0.1\n\n* Initial CRAN submission.\n",
    path(pkg, "NEWS.md")
  )

  expect_no_error(show_news(pkg))
})

test_that("can read NEWS.Rd in inst directory", {
  skip_on_cran()

  pkg <- local_package_create()

  dir_create(pkg, "inst")
  write(
    "\\name{NEWS}
\\title{News for Package 'test'}

\\section{CHANGES IN test VERSION 0.0.1}{
  \\itemize{
    \\item First version
  }
}",
    path(pkg, "inst", "NEWS.Rd")
  )

  expect_no_error(show_news(pkg))
})

test_that("can read NEWS in inst directory", {
  skip_on_cran()

  pkg <- local_package_create()

  dir_create(pkg, "inst")
  write("v0.1-1  (2024-01-09)\n\n  o first release", path(pkg, "inst", "NEWS"))

  expect_no_error(show_news(pkg))
})

test_that("fails when NEWS is missing", {
  skip_on_cran()

  pkg <- local_package_create()

  expect_error(show_news(pkg))
})

test_that("fails when NEWS is improperly formatted", {
  skip_on_cran()

  pkg <- local_package_create()
  suppressMessages(usethis::with_project(pkg, use_news_md()))

  dir_create(pkg, "inst")
  file_create(pkg, "inst", "NEWS.Rd")

  expect_error(show_news(pkg))
})
