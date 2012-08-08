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

  oldenv <- asNamespace("devtools")

  # Duplicate the devtools environment
  newenv_list <- as.list(oldenv, all.names=TRUE)
  # Remove namespace info so R doesn't do weird stuff
  newenv_list[[".__NAMESPACE__."]] <- NULL

  # Create the new environment.
  # Set the parent to global env so it can see basic functions
  newenv <- list2env(newenv_list, parent = globalenv())

  # Change the environment of all the objects that have an environment
  # from <namespace:devtools> to the new environment.
  # Use a loop; doing this with a function and lapply is hard,
  # because environment setting has to be done on the original object,
  # not a pass-by-value copy of it.
  newenv_objs <- ls(newenv, all.names = TRUE)
  for (obj in newenv_objs) {
    obj_env <- environment(newenv[[obj]])

    if (is.null(obj_env))  next

    if (identical(oldenv, obj_env)) {
      # If the object's environment is the old namespace environment,
      # change it to the new environment.
      environment(newenv[[obj]]) <- newenv

    } else if (identical(oldenv, parent.env(obj_env))) {
      # For closures: if the _parent_ env is the old namespace environment,
      # change it to the new environment
      parent.env(obj_env) <- newenv
    }
    # I guess we could keep going for more deeply nested closures, but
    # this should be good enough for our purposes
  }

  # Finally we can reload devtools
  newenv$load_all(pkg, reset)
}
