#' Execute all \pkg{test_that} tests in a package.
#'
#' Tests are assumed to be located in a \code{inst/tests/} directory.
#' See \code{\link[testthat]{test_dir}} for the naming convention of test
#' scripts within that directory.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @inheritParams testthat::test_dir
#' @export
test <- function(pkg = NULL, filter = NULL) {
  pkg <- as.package(pkg)
  load_all(pkg)
  message("Testing ", pkg$package)
  
  path_test <- file.path(pkg$path, "inst", "tests")
  if (!file.exists(path_test)) return()
  
  require(testthat)
  test_dir(path_test, filter = filter)
}
