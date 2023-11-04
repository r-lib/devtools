test_that("vignettes built on install", {
  skip_on_cran()

  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }

  pkg <- local_package_copy(test_path("testVignettesBuilt"))

  withr::local_temp_libpaths()
  install(pkg, reload = FALSE, quiet = TRUE, build_vignettes = TRUE)

  vigs <- vignette(package = "testVignettesBuilt")$results
  expect_equal(nrow(vigs), 1)
  expect_equal(vigs[3], "new")
})
