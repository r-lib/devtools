test_that("Sweave vignettes copied into doc", {
  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }
  pkg <- test_path("testVignettes")
  doc <- path(pkg, "doc")

  suppressMessages(clean_vignettes(pkg))
  expect_false(dir_exists(doc))

  suppressMessages(build_vignettes(pkg))
  expect_setequal(path_file(dir_ls(doc)), c("new.pdf", "new.R", "new.Rnw"))

  suppressMessages(clean_vignettes(pkg))
  expect_false(dir_exists(doc))
})

test_that("Built files are updated", {
  # This test is time dependant and sometimes fails on CRAN because the systems are under heavy load.
  skip_on_cran()
  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }
  pkg <- test_path("testVignettes")

  suppressMessages(clean_vignettes(pkg))
  suppressMessages(build_vignettes(pkg))
  on.exit(suppressMessages(clean_vignettes(pkg)))

  output <- dir_ls(path(pkg, "doc"), regexp = "new")
  first <- file_info(output)$modification_time

  Sys.sleep(.01)
  suppressMessages(build_vignettes(pkg))
  second <- file_info(output)$modification_time

  expect_true(all(second > first))
})

test_that("Rmarkdown vignettes copied into doc", {
  pkg <- test_path("testMarkdownVignettes")
  doc <- path(pkg, "doc")

  suppressMessages(clean_vignettes(pkg))
  expect_false(dir_exists(doc))

  suppressMessages(build_vignettes(pkg))
  expect_setequal(path_file(dir_ls(doc)), c("test.html", "test.R", "test.Rmd"))

  suppressMessages(clean_vignettes(pkg))
  expect_false(dir_exists(doc))
})

test_that("Extra files copied and removed", {
  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }

  pkg <- test_path("testVignetteExtras")
  doc <- path(pkg, "doc")

  extras_path <- path(pkg, "vignettes", ".install_extras")
  writeLines("a.R", extras_path)
  on.exit(file_delete(extras_path))

  suppressMessages(clean_vignettes(pkg))
  expect_false(file_exists(path(doc, "a.R")))

  suppressMessages(build_vignettes(pkg))
  expect_true(file_exists(path(doc, "a.R")))

  suppressMessages(clean_vignettes(pkg))
  expect_false(file_exists(path(doc, "a.R")))
})

test_that("vignettes built on install", {
  skip_on_cran()

  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }

  pkg <- test_path("testVignettesBuilt")

  withr::local_temp_libpaths()
  install(pkg, reload = FALSE, quiet = TRUE, build_vignettes = TRUE)

  vigs <- vignette(package = "testVignettesBuilt")$results
  expect_equal(nrow(vigs), 1)
  expect_equal(vigs[3], "new")
})

test_that(".gitignore updated when building vignettes", {
  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }

  pkg <- test_path("testVignettes")
  gitignore <- path(pkg, ".gitignore")

  suppressMessages(clean_vignettes(pkg))
  suppressMessages(build_vignettes(pkg))
  on.exit(suppressMessages(clean_vignettes(pkg)))

  expect_true(all(c("/Meta/", "/doc/") %in% readLines(gitignore)))
})
