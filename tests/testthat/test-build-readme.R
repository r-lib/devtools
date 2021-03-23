test_that("Package readme can be built ", {
  skip_on_cran()

  on.exit({
    file_delete("testReadme/README.md")
    dir_delete("testReadme/man/figures")
  })

  suppressMessages(build_readme("testReadme"))

  expect_true(file_exists(path("testReadme", "README.md")))
  expect_false(file_exists(path("testReadme", "README.html")))
})
