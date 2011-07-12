#' Use roxygen to make documentation.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param clean if \code{TRUE} will automatically clear all roxygen caches
#'   and delete currently man contents to ensure that you have the freshest
#'   version of the documentation.
#'   check documentation after running roxygen.
#' @keywords programming
#' @export
document <- function(pkg = NULL, clean = FALSE) {
  require("roxygen2")
  
  pkg <- as.package(pkg)
  message("Updating ", pkg$package, " documentation")
  
  if (clean) {
    clear_caches()
    file.remove(dir(file.path(pkg$path, "man"), full = TRUE))
  }
  
  in_dir(pkg$path, roxygenise("."))
    
  # if (check) check_doc(pkg)
  invisible()
}
