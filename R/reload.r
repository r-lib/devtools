#' Detach and reload package.
#' 
#' If the package is not loaded already, this does nothing.
#' 
#' See the caveats in \code{\link{detach}} for the many reasons why this 
#' might not work. If in doubt, quit R and restart.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @examples
#' \dontrun{
#' # Reload package that is in current directory
#' reload(".")
#'
#' # Reload package that is in ./ggplot2/
#' reload("ggplot2/")
#'
#' # Can use inst() to find the package path
#' reload(inst("ggplot2"))
#' }
#' @export
reload <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  name <- env_pkg_name(pkg)
  
  if (is.loaded(pkg)) {
    message("Reloading installed ", pkg$package)
    unload(pkg)
    require(pkg$package, character.only = TRUE, quietly = TRUE)
  }
}

is.loaded <- function(pkg = NULL) {
  env_pkg_name(pkg) %in% search()
}

is.loaded_pkg <- is.loaded

is.loaded_ns <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  pkg$package %in% loadedNamespaces()
}

#' Unload a package
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#'
#' @examples
#' \dontrun{
#' # Unload package that is in current directory
#' unload(".")
#'
#' # Unload package that is in ./ggplot2/
#' unload("ggplot2/")
#'
#' # Can use inst() to find the package path
#' unload(inst("ggplot2"))
#' }
#' @export
unload <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  detach(env_pkg_name(pkg), character.only = TRUE, force = TRUE, unload = TRUE)

  # Clear so that loading the package again will re-read all files
  clear_cache()

  # Do this after detach, so that packages that have an .onUnload function
  # which unloads DLLs (like MASS) won't try to unload the DLL twice.
  unload_dynlibs(pkg)
}

unload_dynlibs <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  libs <- .dynLibs()

  # Get all shared libraries whose name matches this package
  # (can be more than one)
  libs <- libs[vapply(libs, "[[", character(1), "name") == pkg$package]
  if (length(libs) == 0) return(invisible())

  # Get just the paths
  libpaths <- vapply(libs, "[[", character(1), "path")

  # Strip off path and extension
  libnames <- sub("\\.[^\\.]*$", "", basename(libpaths))

  # Installation path of package
  pkgpath <- system.file(package = pkg$package)

  # Unload each entry in libnames
  lapply(libnames, library.dynam.unload, pkgpath)

  invisible()
}
