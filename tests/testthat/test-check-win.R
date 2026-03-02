test_that("parse_winbuilder_form() can extract form fields from live page", {
  skip_on_cran()
  skip_if_not_installed("httr2")
  skip_if_not_installed("xml2")

  url <- "https://win-builder.r-project.org/upload.aspx"

  for (version in c("R-devel", "R-release", "R-oldrelease")) {
    form <- parse_winbuilder_form(url, version)

    expect_named(form, c("hidden", "file_field", "button_field"))
    expect_true("__VIEWSTATE" %in% names(form$hidden))
    expect_true("__VIEWSTATEGENERATOR" %in% names(form$hidden))
    expect_true("__EVENTVALIDATION" %in% names(form$hidden))
    expect_type(form$file_field, "character")
    expect_type(form$button_field, "character")
  }
})

test_that("change_maintainer_email checks fields", {
  path <- withr::local_tempfile()

  desc <- desc::desc(text = "")
  desc$write(path)
  expect_snapshot(change_maintainer_email(path, "x@example.com"), error = TRUE)

  desc <- desc::desc(
    text = c(
      "Authors@R: person('x', 'y')",
      "Maintainer: foo <foo@example.com>"
    )
  )
  desc$write(path)
  expect_snapshot(change_maintainer_email(path, "x@example.com"), error = TRUE)
})

test_that("email confirmation gives useful advice", {
  withr::local_options(rlang_interactive = TRUE)
  local_mocked_bindings(yesno = function(msg) {
    cli::cli_inform(msg, .envir = parent.frame())
    TRUE
  })

  expect_snapshot(confirm_maintainer_email("hadley@posit.co"), error = TRUE)
})
