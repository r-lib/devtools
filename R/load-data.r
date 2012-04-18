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
load_data <- function(pkg = NULL, env = pkg_env(pkg)) {
  pkg <- as.package(pkg)
  objs <- character()
  
  sysdata <- file.path(pkg$path, "R", "sysdata.rda")
  if (file.exists(sysdata)) {
    objs <- c(objs, load(sysdata, envir = env))
  }
  
  path_data <- file.path(pkg$path, "data")
  if (file.exists(path_data)) {
    paths <- dir(path_data, "\\.[rR][dD]a(ta)?$", full.names = TRUE)
    paths <- changed_files(paths)
    objs <- c(objs, unlist(lapply(paths, load, envir = env)))
    
    paths <- dir(path_data, "\\.[rR]$", full.names = TRUE)
    paths <- changed_files(paths)
    objs <- c(objs, unlist(lapply(paths, sys.source, envir = env, 
      chdir = TRUE, keep.source = TRUE)))
  }
    
  invisible(objs)
}
