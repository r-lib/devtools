context("Build README")

test_that("Package readme can be built ", {
  destination <- file.path("testReadme", "README.md")

  on.exit(unlink(c("testReadme/README.md", "testReadme/README.html", "testReadme/man/figures"), recursive = TRUE))

  build_readme("testReadme")

  expect_true(file.exists(destination))
})
