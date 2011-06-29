#' Open bash shell in package directory.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
bash <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  
  in_dir(pkg$path, system("bash"))
}
