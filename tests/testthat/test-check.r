context("Check")

test_that("return messages", {
  skip_on_cran()

  pkg_name <- "testTest"
  check_dir_name <- sprintf("%s.Rcheck", pkg_name)

  on.exit(unlink(check_dir_name, recursive = TRUE), add = TRUE)
  withr::with_envvar(
    list(
      "_R_CHECK_RD_XREFS_"="FALSE",
      "_R_CHECK_CRAN_INCOMING_"="FALSE"
    ),
    check(pkg_name, document = FALSE, cran = FALSE,
          check_dir = ".", cleanup = FALSE, quiet = TRUE)
  )

  failures <- check_failures(check_dir_name, error = TRUE,
                             warning = TRUE, note = TRUE)
  expect_equal(failures, character(), info = paste(failures, collapse = "\n"))
})
