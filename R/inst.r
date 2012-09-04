#' Get the installation path of a package
#'
#' Given the name of a package, this returns a path to the installed
#' copy of the package, which can be passed to other devtools functions.
#'
#' It searches for the package in \code{\link{.libPaths}()}. If multiple
#' dirs are found, it will return the first one.
#'
#' @param name the name of a package.
#'
#' @examples
#' inst("devtools")
#' inst("grid")
#' \dontrun{
#' # Can be passed to other devtools functions
#' unload(inst("ggplot2"))
#' }
#' @export
inst <- function(name) {
  # It would be nice to use find.package or system.file, but they
  # also search in the directory in the 'path' attribute of the
  # package environment.

  # Look in the library paths
  paths <- file.path(.libPaths(), name)
  paths <- paths[dir.exists(paths)]

  if (length(paths) > 0) {
    # If multiple matches, return the first one
    return(normalizePath(paths[1]))
  } else {
    return(NULL)
  }
}
