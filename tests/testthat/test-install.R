show_headers <- function(lines) {
  lines <- cli::ansi_strip(lines)
  lines <- lines[grepl("^--", lines)]
  lines
}

test_that("install reports stages", {
  skip_on_cran()
  local_reproducible_output(width = 60)

  pkg <- local_package_copy(test_path("testTest"))
  withr::local_temp_libpaths()

  expect_snapshot(
    install(pkg, reload = FALSE, build = TRUE),
    transform = show_headers
  )
})

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
