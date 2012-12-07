# Create the package environment where exported objects will be copied to
attach_ns <- function(pkg = ".") {
  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)

  if (is_attached(pkg)) {
    stop("Package ", pkg$package, " is already attached.")
  }

  # This should be similar to attachNamespace
  pkgenv <- attach(NULL, name = pkg_env_name(pkg))
  attr(pkgenv, "path") <- getNamespaceInfo(nsenv, "path")
}

# Invoke namespace load actions. According to the documentation for setLoadActions
# these actions should be called at the end of processing of S4 metadata, after 
# dynamically linking any libraries, the call to .onLoad(), if any, and caching 
# method and class definitions, but before the namespace is sealed
run_ns_load_actions <- function(pkg = ".") {
  nsenv <- ns_env(pkg)
  actions <- methods::getLoadActions(nsenv)
  for (action in actions) 
    action(nsenv)
}

# Copy over the objects from the namespace env to the package env
export_ns <- function(pkg = ".") {
  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)
  pkgenv <- pkg_env(pkg)

  exports <- getNamespaceExports(nsenv)
  importIntoEnv(pkgenv, exports, nsenv, exports)
}


#' Return package environment
#'
#' This is an environment like \code{<package:pkg>}. The package
#' environment contains the exported objects from a package. It is
#' attached, so it is an ancestor of \code{R_GlobalEnv}.
#'
#' When a package is loaded the normal way, using \code{\link{library}},
#' this environment contains only the exported objects from the
#' namespace. However, when loaded with \code{\link{load_all}}, this
#' environment will contain all the objects from the namespace, unless
#' \code{load_all} is used with \code{export_all=FALSE}.
#'
#' If the package is not attached, this function returns \code{NULL}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @seealso \code{\link{ns_env}} for the namespace environment that
#'   all the objects (exported and not exported).
#' @seealso \code{\link{imports_env}} for the environment that contains
#'   imported objects for the package.
#' @export
pkg_env <- function(pkg = ".") {
  pkg <- as.package(pkg)
  name <- pkg_env_name(pkg)

  if (!is_attached(pkg)) return(NULL)

  as.environment(name)
}


# Generate name of package environment
# Contains exported objects
pkg_env_name <- function(pkg = ".") {
  pkg <- as.package(pkg)
  paste("package:", pkg$package, sep = "")
}


# Reports whether a package is loaded and attached
is_attached <- function(pkg = ".") {
  pkg_env_name(pkg) %in% search()
}
