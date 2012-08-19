#' Package imports environment
#'
#' Contains objects imported from other packages. Is the parent of the
#' package namespace environment, and is a child of <namespace:base>,
#' which is a child of R_GlobalEnv,
#' @export
imports_env <- function(pkg = NULL) {
  pkg <- as.package(pkg)

  if (!is_loaded(pkg)) {
    stop("Namespace environment must be created before accessing imports environment.")
  }

  env <- parent.env(ns_env(pkg))

  if (attr(env, 'name') != imports_env_name(pkg)) {
    stop("Imports environment does not have attribute 'name' with value ",
      imports_env_name(pkg),
      ". This probably means that the namespace environment was not created correctly.")
  }

  env
}


# Generate name of package imports environment
# Contains exported objects
imports_env_name <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  paste("imports:", pkg$package, sep = "")
}
