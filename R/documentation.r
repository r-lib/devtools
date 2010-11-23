#' Use roxygen to make documentation.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @export
document <- function(pkg) {
  pkg <- as.package(pkg)
  
  require(roxygen)
  if (exists("roxygenise")) {
    # My version of roxygen
    roxygenise(pkg$path, pkg$path, roclets = c("had", "collate", "namespace"))
  } else {
    # Standard version of roxygen
    roxygenize(pkg$path, pkg$path)
  }
  
}