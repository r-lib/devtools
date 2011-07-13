#' Set working directory.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param path path within package. Leave empty to change working directory
#'   to package directory.
#' @export
wd <- function(pkg = NULL, path = NULL) {
  pkg <- as.package(pkg)
  path <- file.path(pkg$path, path)
  
  if (!file.exists(path)) {
    stop(path, " does not exist", call. = FALSE)
  }
  
  message("Changing working directory to ", path)
  setwd(path)
}