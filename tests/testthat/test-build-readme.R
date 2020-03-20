context("Build README")

test_that("Package readme can be built ", {
  skip_on_cran()

  on.exit(unlink(c("testReadme/README.md", "testReadme/man/figures"), recursive = TRUE))

  build_readme("testReadme")

  expect_true(file.exists(file.path("testReadme", "README.md")))
  expect_false(file.exists(file.path("testReadme", "README.html")))
})
