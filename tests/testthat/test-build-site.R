test_that("Package pkgdown site can be built ", {
  # This test requires internet
  skip_if_offline()
  skip_on_cran()

  destination <- path(tempdir(), "testPkgdown", "docs")

  build_output <- capture.output(
    {
      build_site(
        path = "testPkgdown",
        override = list(destination = destination)
      )
    },
    type = c("output")
  )

  build_output <- paste(build_output, collapse = "\n")

  expect_true(
    file_exists(path(destination, "index.html")),
    info = build_output,
    label = "created site index"
  )
  expect_true(
    file_exists(path(destination, "reference", "index.html")),
    info = build_output,
    label = "created reference index"
  )
  expect_true(
    file_exists(path(destination, "articles", "index.html")),
    info = build_output,
    label = "created articles index"
  )
  expect_true(
    file_exists(path(destination, "articles", "test.html")),
    info = build_output,
    label = "created articles index"
  )
})
