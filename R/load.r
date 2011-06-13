#' Load complete package.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param reset clear package environment and reset file cache before loading
#'   any pieces of the package.
#' 
#' @keywords programming
#' @export
load_all <- function(pkg, reset = FALSE) {
  pkg <- as.package(pkg)
  
  # If installed version of package loaded, unload it
  if (is.loaded(pkg) && is.locked(pkg)) {
    unload(pkg)
  }
  
  # Load dependencies before creating environment so it sees all the required
  # packages
  load_deps(pkg)

  if (reset) {
    clear_cache()
    clear_classes(pkg)
    clear_pkg_env(pkg)
  }
  
  env <- pkg_env(pkg)
  load_data(pkg, env)
  load_code(pkg, env)
  load_c(pkg)

  invisible()  
}

#' Load package as development or installed verison.
#' 
#' If package exists in known development location on disk, load it from
#' there.  Otherwise load the installed package with \code{\link{library}}.
#'
#' @keywords programming
#' @export
load_or_library <- function(pkg, ...) {
  path <- find_package(pkg)
  
  if (is.null(path)) {
    library(pkg, character.only = TRUE)
  } else {
    load_all(as.package(path), ...)
  }
}

is.locked <- function(pkg) {
  environmentIsLocked(as.environment(env_name(pkg)))
}