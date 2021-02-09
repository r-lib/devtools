test_that("Sweave vignettes copied into doc", {
  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }
  pkg <- test_path("testVignettes")
  doc <- file.path(pkg, "doc")

  suppressMessages(clean_vignettes(pkg))
  expect_equal(dir(doc), character())

  suppressMessages(build_vignettes(pkg))
  expect_setequal(dir(doc), c("new.pdf", "new.R", "new.Rnw"))

  suppressMessages(clean_vignettes(pkg))
  expect_equal(dir(doc), character())
})

test_that("Built files are updated", {
  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }
  pkg <- test_path("testVignettes")

  suppressMessages(clean_vignettes(pkg))
  suppressMessages(build_vignettes(pkg))
  on.exit(suppressMessages(clean_vignettes(pkg)))

  output <- dir(file.path(pkg, "doc"), "new", full.names = TRUE)
  first <- file.info(output)$mtime

  Sys.sleep(1)
  suppressMessages(build_vignettes(pkg))
  second <- file.info(output)$mtime

  expect_true(all(second > first))
})

test_that("Rmarkdown vignettes copied into doc", {
  pkg <- test_path("testMarkdownVignettes")
  doc <- file.path(pkg, "doc")

  suppressMessages(clean_vignettes(pkg))
  expect_equal(dir(doc), character())

  suppressMessages(build_vignettes(pkg))
  expect_setequal(dir(doc), c("test.html", "test.R", "test.Rmd"))

  suppressMessages(clean_vignettes(pkg))
  expect_equal(dir(doc), character())
})

test_that("Extra files copied and removed", {
  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }

  pkg <- test_path("testVignetteExtras")
  doc <- file.path(pkg, "doc")

  extras_path <- file.path(pkg, "vignettes", ".install_extras")
  writeLines("a.R", extras_path)
  on.exit(unlink(extras_path))

  suppressMessages(clean_vignettes(pkg))
  expect_false(file.exists(file.path(doc, "a.R")))

  suppressMessages(build_vignettes(pkg))
  expect_true(file.exists(file.path(doc, "a.R")))

  suppressMessages(clean_vignettes(pkg))
  expect_false(file.exists(file.path(doc, "a.R")))
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
  gitignore <- file.path(pkg, ".gitignore")

  suppressMessages(clean_vignettes(pkg))
  suppressMessages(build_vignettes(pkg))
  on.exit(suppressMessages(clean_vignettes(pkg)))

  expect_true(all(c("/Meta/", "/doc/") %in% readLines(gitignore)))
})
