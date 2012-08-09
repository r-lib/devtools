#' Get the installation path of a package
#'
#' Given the name of a package, this returns a path to the package,
#' which can be passed to other devtools functions.
#'
#' This will first check if there's a loaded package matching the name.
#' If so, it will return the \code{path} attribute of the package
#' environment.
#'
#' Next it will look for a directory with the name. Finally, it will
#' search in the lib paths for a directory with that name. If multiple
#' dirs are found, it will return the first one.
#'
#' @param name the name of a package or the installation dir of a
#'   package. If it's a directory, a relative path may be used.
#'
#' @examples
#' inst(".")
#' inst("devtools")
#' inst("grid")
#' \dontrun{
#' # Can be passed to other devtools functions
#' unload(inst("ggplot2"))
#' }
#' @export
inst <- function(name) {

  # First check loaded packages for a path attribute
  envs <- search()
  pkgenv_name <- envs[grep(paste("^package:", name, "$", sep = ""), envs)]

  if (length(pkgenv_name) > 0) {
    pkgenv <- as.environment(pkgenv_name)
    pkgpath <- attr(pkgenv, "path")

    if (!is.null(pkgpath))
      return(pkgpath)
  }

  # If loaded package with path not found, look for a directory with the
  # name
  if (file.exists(name) && file.info(name)$isdir) {
    return(normalizePath(name))
  }

  # Look in the library paths
  paths <- file.path(.libPaths(), name)
  paths <- paths[file.exists(paths)]
  paths <- paths[file.info(paths)$isdir]

  if (length(paths) > 0) {
    return(normalizePath(paths[1]))
  } else {
    return(NULL)
  }
}

inst('.')
inst('devtools')
inst('grid')
