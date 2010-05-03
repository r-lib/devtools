#' Use roxygen to make documentation
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @export
make_docs <- function(pkg) {
  pkg <- as.package(pkg)
  
  roxygenise(pkg$path, pkg$path, roclets = c("had", "collate", "namespace"))
}