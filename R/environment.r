#' Generate an development environment for a package.
#' \code{devtools} keeps the global workspace clean by loading all code and
#' data into a separate environment.  This environment is 
#' \code{\link{attach}}ed to the search path just after the global environment
#' so it will override loaded packages.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
pkg_env <- function(pkg) {
  pkg <- as.package(pkg)
  name <- env_name(pkg)
  
  if (!(name %in% search())) {
    attach(new.env(parent = emptyenv()), name = name)
  }
  
  as.environment(name)
}

#' Detach development environment
#' @keywords internal
clear_pkg_env <- function(pkg) {
  name <- env_name(pkg)
  
  if (name %in% search()) {
    detach(name, character.only = TRUE)
  }  
}

#' Generate name of package development environment
#' @keywords internal
env_name <- function(pkg) {
  pkg <- as.package(pkg)
  stringr::str_c("package:", pkg$package)
}