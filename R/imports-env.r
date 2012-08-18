
#' Package imports environment
#' Contains objects imported from other packages. Is the parent of the
#' package namespace environment, and is a child of <namespace:base>,
#' which is a child of R_GlobalEnv,
#' @export
imports_env <- function(pkg = NULL) {
  pkg <- as.package(pkg)

  if (!is.loaded_ns(pkg)) {
    stop("Namespace environment must be created before accessing imports environment.")
  }

  env <- parent.env(ns_env(pkg))

  if (attr(env, 'name') != env_imports_name(pkg)) {
    stop("Imports environment does not have attribute 'name' with value ",
      env_imports_name(pkg),
      ". This probably means that the namespace environment was not created correctly.")
  }

  env
}


# Generate name of package imports environment
# Contains exported objects
env_imports_name <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  paste("imports:", pkg$package, sep = "")
}
