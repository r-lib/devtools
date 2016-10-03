context("Release checks")

test_that("check_doc_files", {
  path <- file.path(tempdir(), "testpkg1")
  if (length(dir(path))) unlink(path, recursive = TRUE)
  capture.output(create(path))
  use_vignette("example", path)

  expect_message(capture.output(check_doc_files(path)), NA)

  build_vignettes(path)
  expect_message(capture.output(check_doc_files(path)))
})
