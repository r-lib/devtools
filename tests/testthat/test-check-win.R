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
  local_mocked_bindings(yesno = function(msg) {
    cli::cli_inform(msg, .envir = parent.frame())
    TRUE
  })

  expect_snapshot(confirm_maintainer_email("hadley@posit.co"), error = TRUE)
})
