test_that("Sweave vignettes copied into doc", {
  withr::local_options(lifecycle_verbosity = "quiet")
  if (!pkgbuild::has_latex()) {
    skip("pdflatex not available")
  }

  pkg <- local_package_copy(test_path("testVignettes"))

  suppressMessages(build_vignettes(pkg, quiet = TRUE))
  expect_setequal(
    path_file(dir_ls(path(pkg, "doc"))),
    c("new.pdf", "new.R", "new.Rnw")
  )
})

test_that("Built files are updated", {
  withr::local_options(lifecycle_verbosity = "quiet")
  # This test is time dependant and sometimes fails on CRAN because the systems are under heavy load.
  skip_on_cran()
  pkg <- local_package_copy(test_path("testMarkdownVignettes"))

  suppressMessages(build_vignettes(pkg, quiet = TRUE))
  output <- dir_ls(path(pkg, "doc"), regexp = "new")
  first <- file_info(output)$modification_time

  Sys.sleep(.01)
  suppressMessages(build_vignettes(pkg, quiet = TRUE))
  second <- file_info(output)$modification_time

  expect_true(all(second > first))
})

test_that("Rmarkdown vignettes copied into doc", {
  withr::local_options(lifecycle_verbosity = "quiet")
  pkg <- local_package_copy(test_path("testMarkdownVignettes"))
  doc <- path(pkg, "doc")

  suppressMessages(build_vignettes(pkg, quiet = TRUE))
  expect_setequal(path_file(dir_ls(doc)), c("test.html", "test.R", "test.Rmd"))
})

test_that("extra files copied and removed", {
  withr::local_options(lifecycle_verbosity = "quiet")
  pkg <- local_package_copy(test_path("testMarkdownVignettes"))
  writeLines("a <- 1", path(pkg, "vignettes", "a.R"))

  extras_path <- path(pkg, "vignettes", ".install_extras")
  writeLines("a.R", extras_path)

  suppressMessages(build_vignettes(pkg, quiet = TRUE))
  expect_true(file_exists(path(pkg, "doc", "a.R")))

  suppressMessages(clean_vignettes(pkg))
  expect_false(file_exists(path(pkg, "doc", "a.R")))
})

test_that(".gitignore updated when building vignettes", {
  withr::local_options(lifecycle_verbosity = "quiet")
  pkg <- local_package_copy(test_path("testMarkdownVignettes"))
  gitignore <- path(pkg, ".gitignore")

  suppressMessages(build_vignettes(pkg, quiet = TRUE))
  expect_true(all(c("/Meta/", "/doc/") %in% readLines(gitignore)))
})

test_that("build_vignettes() and clean_vignettes() are deprecated", {
  pkg <- local_package_create()
  expect_snapshot({
    build_vignettes(pkg)
    clean_vignettes(pkg)
  })
})
