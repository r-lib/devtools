context("bioc")

test_that("bioc repo paths are parsed correctly", {
  expect_equal(parse_bioc_repo("devtools#abc123"), list(repo="devtools", commit="abc123"))
  expect_equal(parse_bioc_repo("user:pass@devtools"), list(username = "user", password = "pass", repo="devtools"))
  expect_equal(parse_bioc_repo("devel/devtools"), list(release = "devel", repo="devtools"))
  expect_equal(parse_bioc_repo("3.1/devtools"), list(release = "3.1", repo="devtools"))
  expect_equal(parse_bioc_repo("release/devtools"), list(release = "release", repo="devtools"))
  expect_equal(parse_bioc_repo("user:pass@devtools#abc123"), list(username = "user", password = "pass", repo="devtools", commit = "abc123"))
  expect_error(parse_bioc_repo("user:pass@3.1/devtools#abc123"), "release and commit should not both be specified")
  expect_error(parse_bioc_repo("user@devtools"), "Invalid bioc repo")
  expect_error(parse_bioc_repo("user:@devtools"), "Invalid bioc repo")
  expect_error(parse_bioc_repo("@devtools"), "Invalid bioc repo")
  expect_error(parse_bioc_repo("devtools/"), "Invalid bioc repo")
  expect_error(parse_bioc_repo("junk/devtools"), "Invalid bioc repo")
})

test_that("install_bioc", {
  skip_if_not(nzchar(Sys.getenv("DEVTOOLS_TEST_BIOC", "")))

  lib <- tempfile()
  on.exit(unlink(lib, recursive = TRUE), add = TRUE)
  dir.create(lib)
  libpath <- .libPaths()
  on.exit(.libPaths(libpath), add = TRUE)
  .libPaths(lib)

  # unload BiocInstaller if it is already loaded, unload it after this function
  # finishes as well
  unloadNamespace("BiocInstaller")
  on.exit(unloadNamespace("BiocInstaller"), add = TRUE)

  # Install BiocInstaller to the new library
  source("https://bioconductor.org/biocLite.R")

  # This package has no dependencies or compiled code and is old
  install_bioc("MeasurementError.cor", quiet = TRUE)

  expect_silent(packageDescription("MeasurementError.cor", lib.loc = .libPaths()))
  expect_equal(packageDescription("MeasurementError.cor", lib.loc = .libPaths())$RemoteType, "bioc")
})
