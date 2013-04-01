#' Load data.
#'
#' Loads all \code{.Rdata} files in the data subdirectory.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @export
load_data <- function(pkg = ".") {
  # Note that this simulates normal R package loading by placing the data sets
  # in the .__NAMESPACE__.$lazydata environment, but unlike with proper lazy
  # loading via lazyLoad(), we'll need to manually copy these objects over to
  # the package environment later.

  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)
  lazydata_env <- nsenv$.__NAMESPACE__.$lazydata
  objs <- character()

  sysdata <- file.path(pkg$path, "R", "sysdata.rda")
  if (file.exists(sysdata)) {
    objs <- c(objs, load(sysdata, envir = nsenv))
  }

  path_data <- file.path(pkg$path, "data")
  if (file.exists(path_data)) {
    paths <- dir(path_data, "\\.[rR][dD]a(ta)?$", full.names = TRUE)
    paths <- changed_files(paths)
    objs <- c(objs, unlist(lapply(paths, load, envir = lazydata_env)))

    paths <- dir(path_data, "\\.[rR]$", full.names = TRUE)
    paths <- changed_files(paths)
    objs <- c(objs, unlist(lapply(paths, sys.source, envir = lazydata_env,
      chdir = TRUE, keep.source = TRUE)))
  }

  invisible(objs)
}
