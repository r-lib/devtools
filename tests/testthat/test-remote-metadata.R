context("remote-metadata")

## set-up and tear-down
create_in_temp <- function(pkg) {
  temp_path <- tempfile(pattern="devtools-test-")
  dir.create(temp_path)
  test_pkg <- file.path(temp_path, pkg)
  capture.output(suppressMessages(create(test_pkg)))
  test_pkg
}
erase <- function(path) unlink(path, recursive = TRUE)

## fake GitHub connectivity: set a GitHub remote and add GitHub links
mock_use_github <- function(pkg) {
  use_git(pkg = pkg)
  r <- git2r::repository(pkg)
  git2r::remote_add(r, "origin", "https://github.com/hadley/devtools.git")
  use_github_links(pkg)
  git2r::add(r, "DESCRIPTION")
  git2r::commit(r, "Add GitHub links to DESCRIPTION")
  invisible(NULL)
}

test_that("install on packages adds metadata", {
  skip_on_cran()

  # # Make a temp lib directory to install test package into
  old_libpaths <- .libPaths()
  tmp_libpath = file.path(tempdir(), "devtools_test")
  if (!dir.exists(tmp_libpath)) dir.create(tmp_libpath)
  .libPaths(c(tmp_libpath, .libPaths()))

  # Reset the libpath on exit
  on.exit(.libPaths(old_libpaths), add = TRUE)

  test_pkg <- create_in_temp("testMetadataInstall")
  mock_use_github(test_pkg)

  # first do metadata = NULL
  install(test_pkg, quiet = TRUE, metadata = NULL)
  library("testMetadataInstall")

  pkg_info <- session_info()$packages
  expect_equal(pkg_info[pkg_info[, "package"] %in% "testMetadataInstall", "source"],
               "local")

  # now use default
  r <- git2r::repository(test_pkg)

  # then use metadata
  install(test_pkg, quiet = TRUE)
  library("testMetadataInstall")
  pkg_info <- session_info()$packages
  pkg_source <- pkg_info[pkg_info[, "package"] %in% "testMetadataInstall", "source"]
  pkg_sha <- substring(git2r::commits(r)[[1]]@sha, 1, 7)
  expect_match(pkg_source, pkg_sha)

  # dirty the repo
  cat("just a test", file = file.path(test_pkg, "test.txt"))
  install(test_pkg, quiet = TRUE)
  pkg_info <- session_info()$packages
  pkg_source <- pkg_info[pkg_info[, "package"] %in% "testMetadataInstall", "source"]
  expect_match(pkg_source, "local")

})
