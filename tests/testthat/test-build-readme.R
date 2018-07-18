context("Build README")

test_that("Package readme can be built ", {
  destination <- file.path("testReadme", "README.md")

  on.exit(unlink("testReadme/README.md"))
  build_readme("testReadme")

  expect_true(file.exists(destination))
})
