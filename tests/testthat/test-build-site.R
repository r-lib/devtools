test_that("Package pkgdown site can be built ", {
  # This test requires internet
  skip_if_offline()
  skip_on_cran()

  destination <- path(tempdir(), "testPkgdown", "docs")

  expect_snapshot(build_site(
    path = "testPkgdown",
    override = list(destination = destination)
  ))

  expect_true(file_exists(path(destination, "index.html")))
  expect_true(file_exists(path(destination, "reference", "index.html")))
  expect_true(file_exists(path(destination, "articles", "index.html")))
  expect_true(file_exists(path(destination, "articles", "test.html")))
})
