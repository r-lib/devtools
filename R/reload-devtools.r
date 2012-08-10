#' Reload the devtools package
#'
#' Special care must be take to reload the devtools package, for a
#' number of reasons. First, if devtools was loaded with
#' \code{library()}, its namespace environment will be locked.
#' Second, even if it is not locked, if you use \code{load_all}
#' with \code{reset=TRUE}, then the utility functions that are used
#' to load the package will be deleted before it is actually
#' reloaded.
#'
#' This function avoids these problems by creating a duplicate of the
#' devtools namespace environment, and then calls \code{load_all}
#' from the duplicate environment.
#'
#' @param pkg package description, can be path or package name.  This
#'   must be the devtools package.
#' @param reset clear package environment and reset file cache before loading
#'   any pieces of the package.
reload_devtools <- function(pkg = NULL, reset = FALSE) {
  pkg <- as.package(pkg)

  newenv <- copy_env(ns_env(pkg), ignore = ".__NAMESPACE__.")

  # Now we can reload devtools by calling load_all from the new environment
  newenv$load_all(pkg, reset, self = TRUE)
}
