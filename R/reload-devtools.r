#' Reload the devtools package
#'
#' Special care must be take to reload the devtools package. Attempts
#' to detach and unregister the devtools namespace from within a
#' function in the devtools namespace don't seem to work; the
#' namespace seems to re-register itself.
#'
#' This function dodges the problem by creating a copy of the
#' devtools namespace environment, and then calls \code{load_all}
#' from the duplicate environment.
#'
#' @param pkg package description, can be path or package name.  This
#'   must be the devtools package.
reload_devtools <- function(pkg = NULL, ...) {
  pkg <- as.package(pkg)

  newenv <- copy_env(ns_env(pkg), ignore = ".__NAMESPACE__.")
  # It's not entirely clear why this works, since the parent env of
  # newenv$load_all is still <namespace:devtools>.
  # Also, if you only copy over load_all, the reloading fails:
  # newenv <- new.env(parent = emptyenv())
  # newenv$load_all <- load_all

  # Now we can reload devtools by calling load_all from the new environment
  newenv$load_all(pkg, ..., self = TRUE)
}
