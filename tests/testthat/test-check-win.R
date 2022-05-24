test_that("change_maintainer_email checks fields", {
  path <- withr::local_tempfile()

  desc <- desc::desc(text = "")
  desc$write(path)
  expect_snapshot(change_maintainer_email(path, "x@example.com"), error = TRUE)

  desc <- desc::desc(text = c(
    "Authors@R: person('x', 'y')",
    "Maintainer: foo <foo@example.com>"
  ))
  desc$write(path)
  expect_snapshot(change_maintainer_email(path, "x@example.com"), error = TRUE)
})
