#' Execute all test_that tests in a package
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
test <- function(pkg) {
  pkg <- as.package(pkg)
  
  path_test <- file.path(pkg$path, "inst", "tests")
  if (!file.exists(path_test)) return()
  
  test_dir(path_test)
}