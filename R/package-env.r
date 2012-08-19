# Create the package environment where objects will be copied to
attach_ns <- function(pkg) {
  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)

  if (is.loaded_pkg(pkg)) {
    stop("Package ", pkg$package, " is already attached.")
  }

  # This should be similar to attachNamespace
  pkgenv <- attach(new.env(parent = emptyenv()), name = pkg_env_name(pkg))
  attr(pkgenv, "path") <- getNamespaceInfo(nsenv, "path")
}


# Copy over the objects from the namespace env to the package env
export_ns <- function(pkg, export_all = TRUE) {
  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)
  pkgenv <- pkg_env(pkg)

  if (export_all) {
    # Copy all the objects from namespace env to package env, so that they
    # are visible in global env.
    copy_env(nsenv, pkgenv,
      ignore = c(".__NAMESPACE__.", ".__S3MethodsTable__.",
        ".packageName", ".First.lib", ".onLoad", ".onAttach",
        ".conflicts.OK", ".noGenerics"))

  } else {
    # Export only the objects specified in NAMESPACE
    # This code from base::attachNamespace
    exports <- getNamespaceExports(nsenv)
    importIntoEnv(pkgenv, exports, nsenv, exports)
  }
}


#' Return package environment
#'
#' This is an environment like \code{<package:pkg>}. It is attached,
#' so it is an ancestor of \code{R_GlobalEnv}.
#'
#' When a package is loaded the normal way, using \code{\link{library}},
#' this environment contains only the exported objects from the
#' namespace. However, when loaded with \code{\link{load_all}}, this
#' environment will contain all the objects from the namespace.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
pkg_env <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  name <- pkg_env_name(pkg)
  
  if (!is.loaded_pkg(pkg)) return(NULL)

  as.environment(name)
}


#' Detach development environment
#' @keywords internal
clear_pkg_env <- function(pkg = NULL) {
  
  if (is.loaded_pkg(pkg)) {
    unload(pkg)
  }  
}


# Generate name of package environment
# Contains exported objects
pkg_env_name <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  paste("package:", pkg$package, sep = "")
}


base_env <- function(pkg) {
  new.env(parent = emptyenv())
}
