context("Vignettes")

test_that("Sweave vignettes copied into doc", {
  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }

  clean_vignettes("testVignettes")
  expect_false("new.pdf" %in% dir("testVignettes/doc"))
  expect_false("new.R" %in% dir("testVignettes/doc"))
  expect_false("new.Rnw" %in% dir("testVignettes/doc"))

  build_vignettes("testVignettes")
  expect_true("new.pdf" %in% dir("testVignettes/doc"))
  expect_true("new.R" %in% dir("testVignettes/doc"))
  expect_true("new.Rnw" %in% dir("testVignettes/doc"))

  clean_vignettes("testVignettes")
  expect_false("new.pdf" %in% dir("testVignettes/doc"))
  expect_false("new.R" %in% dir("testVignettes/doc"))
  expect_false("new.Rnw" %in% dir("testVignettes/doc"))
})

test_that("Built files are updated", {
  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }

  clean_vignettes("testVignettes")
  build_vignettes("testVignettes")
  on.exit(clean_vignettes("testVignettes"))

  output <- dir("testVignettes/doc", "new", full.names = TRUE)
  first <- file.info(output)$mtime

  Sys.sleep(1)
  build_vignettes("testVignettes")
  second <- file.info(output)$mtime

  expect_true(all(second > first))
})

if (packageVersion("knitr") >= 1.2) {
  test_that("Rmarkdown vignettes copied into doc", {
    pkg <- as.package("testMarkdownVignettes")
    doc_path <- file.path(pkg$path, "doc")

    clean_vignettes(pkg)
    expect_false("test.html" %in% dir(doc_path))
    expect_false("test.R" %in% dir(doc_path))
    expect_false("test.Rmd" %in% dir(doc_path))

    build_vignettes(pkg)
    expect_true("test.html" %in% dir(doc_path))
    expect_true("test.R" %in% dir(doc_path))
    expect_true("test.Rmd" %in% dir(doc_path))

    clean_vignettes(pkg)
    expect_false("test.html" %in% dir(doc_path))
    expect_false("test.R" %in% dir(doc_path))
    expect_false("test.Rmd" %in% dir(doc_path))
  })
}


test_that("Extra files copied and removed", {
  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }

  pkg <- as.package("testVignetteExtras")
  doc_path <- file.path(pkg$path, "doc")

  extras_path <- file.path(
    "testVignetteExtras", "vignettes",
    ".install_extras"
  )
  writeLines("a.R", extras_path)
  on.exit(unlink(extras_path))

  clean_vignettes(pkg)
  expect_false("a.R" %in% dir(doc_path))

  build_vignettes(pkg)
  expect_true("a.R" %in% dir(doc_path))

  clean_vignettes(pkg)
  expect_false("a.R" %in% dir(doc_path))
})


test_that("vignettes built on install", {
  # Since we install this package it should not run on CRAN, as it would change
  # the default library
  skip_on_cran()

  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }

  install("testVignettesBuilt",
    reload = FALSE, quiet = TRUE,
    build_vignettes = TRUE
  )
  unlink("testVignettesBuilt/vignettes/new.tex")
  unlink("testVignettesBuilt/vignettes/.build.timestamp")

  vigs <- vignette(package = "testVignettesBuilt")$results
  expect_equal(nrow(vigs), 1)
  expect_equal(vigs[3], "new")

  suppressMessages(remove.packages("testVignettesBuilt"))
})
