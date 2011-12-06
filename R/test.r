#' Execute all test_that tests in a package
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
