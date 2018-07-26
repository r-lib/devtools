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

  withr::with_temp_libpaths({

    # unload BiocManager if it is already loaded, unload it after this function
    # finishes as well

    if (getRversion() < "3.5") {
      unloadNamespace("BiocInstaller")
      on.exit(unloadNamespace("BiocInstaller"), add = TRUE)

      # Install BiocInstaller to the new library, we use http here because R <
      # 3.2 does not support https.
      source("http://bioconductor.org/biocLite.R")
    } else {
      unloadNamespace("BiocManager")
      on.exit(unloadNamespace("BiocManager"), add = TRUE)

      # Install BiocManager to the new library
      install.packages("BiocManager", repos = "https://cloud.r-project.org")
    }

    # This package has no dependencies or compiled code and is old
    install_bioc("MeasurementError.cor", quiet = TRUE)

    expect_silent(packageDescription("MeasurementError.cor", lib.loc = .libPaths()))
    expect_equal(packageDescription("MeasurementError.cor", lib.loc = .libPaths())$RemoteType, "bioc")
  })
})
