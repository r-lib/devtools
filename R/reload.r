#' Detach and reload package.
#' 
#' If the package is not loaded already, this does nothing.
#' 
#' See the caveats in \code{\link{detach}} for the many reasons why this 
#' might not work. If in doubt, quit R and restart.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
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

unload <- function(pkg = NULL) {
  detach(env_pkg_name(pkg), character.only = TRUE, force = TRUE, unload = TRUE)
}
