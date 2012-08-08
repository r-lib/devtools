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
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param reset clear package environment and reset file cache before loading
#'   any pieces of the package.
#'
#' @export
reload_devtools <- function(pkg = NULL, reset = FALSE) {
  pkg <- as.package(pkg)
  if (pkg$package != "devtools") {
    stop("This function can only be used to reload devtools, but you are trying to load ",
      pkg$package)
  }

  # Duplicate the devtools environment
  newenv_list <- as.list(asNamespace("devtools"), all.names=TRUE)
  # Remove namespace info so R doesn't do weird stuff
  newenv_list[[".__NAMESPACE__."]] <- NULL

  # Create the new environment.
  # Set the parent to global env so it can see basic functions
  newenv <- list2env(newenv_list, parent = globalenv())

  # Finally we can reload devtools
  newenv$load_all(pkg, reset)
}
