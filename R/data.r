#' Load data.
#'
#' Loads all \code{.Rdata} files in the data subdirectory.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param env environment in which to load code.  Defaults to \code{devel:pkg}
#'   which is attached just after the global environment.  See
#'  \code{\link{pkg_env}} for more information
#' @keywords programming
#' @export
load_data <- function(pkg, env = pkg_env(pkg)) {
  pkg <- as.package(pkg)
  
  path_data <- file.path(pkg$path, "data")
  if (!file.exists(path_data)) return(invisible())
  
  paths <- dir(path_data, "\\.[rR]da(ta)?$", full = TRUE)
  paths <- changed_files(paths)

  objs <- unlist(plyr::llply(paths, load, envir = env))
  invisible(objs)
}
