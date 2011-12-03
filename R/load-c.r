#' Load C code.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @export
load_c <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  
  path_src <- file.path(pkg$path, "src")
  if (!file.exists(path_src)) return(invisible())
  
  paths <- dir(path_src, "\\.(so|dll)$", full = TRUE)

  lapply(paths, dyn.load)
  invisible(paths)
}
