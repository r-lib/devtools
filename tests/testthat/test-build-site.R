context("Build Site")

test_that("Package pkgdown site can be built ", {
  # This test requires internet
  skip_on_cran()

  destination <- file.path(tempdir(), "testPkgdown", "docs")

  build_output <- capture.output({
    build_site(
      path = "testPkgdown",
      override = list(destination = destination)
    )
  }, type = c("output"))

  build_output <- paste(build_output, collapse = "\n")

  expect_true(file.exists(file.path(destination, "index.html")),
    info = build_output,
    label = "created site index"
  )
  expect_true(file.exists(file.path(destination, "reference", "index.html")),
    info = build_output,
    label = "created reference index"
  )
  expect_true(file.exists(file.path(destination, "articles", "index.html")),
    info = build_output,
    label = "created articles index"
  )
  expect_true(file.exists(file.path(destination, "articles", "test.html")),
    info = build_output,
    label = "created articles index"
  )
})
