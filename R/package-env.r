#' Generate a namespace environment for a package.
#'
#' Contains all (exported and non-exported) objects, and is a descendent of
#' \code{R_GlobalEnv}. The hieararchy is \code{<namespace:pkg>}, 
#' \code{<imports:pkg>}, \code{<namespace:base>}, and then
#' \code{R_GlobalEnv}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param create if namespace environment doesn't already exist,
#'   create it?
#' @keywords programming
#' @export
ns_env <- function(pkg = NULL, create = FALSE) {
  pkg <- as.package(pkg)
  name <- env_ns_name(pkg)

  if (!is.loaded_ns(pkg)) {
    if (create) {
      env <- makeNamespace(pkg$package)
      setPackageName(pkg$package, env)
    } else {
      return(NULL)
    }
  } else {
    env <- asNamespace(pkg$package)
  }

  env
}


#' Generate a package environment
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
#' @param create if package environment doesn't already exist,
#'   create it?
#' @export
pkg_env <- function(pkg = NULL, create = FALSE) {
  pkg <- as.package(pkg)
  name <- env_pkg_name(pkg)
  
  if (!is.loaded_pkg(pkg)) {
    if (create) {
      pkgenv <- attach(new.env(parent = emptyenv()), name = name)
      attr(pkgenv, "path") <- pkg$path
    } else {
      return(NULL)
    }
  }

  as.environment(name)
}

#' Package imports environment
#' Contains objects imported from other packages. Is a child of R_GlobalEnv
#' and is the parent of the package namespace environment.
#' @export
pkg_imports_env <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  name <- env_pkg_name(pkg)

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

#' Detach development environment
#' @keywords internal
clear_pkg_env <- function(pkg = NULL) {
  
  if (is.loaded(pkg)) {
    unload(pkg)
  }  
}

#' Generate name of package namespace environment
#' Contains all objects
#' @keywords internal
env_ns_name <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  paste("namespace:", pkg$package, sep = "")
}

#' Generate name of package environment
#' Contains exported objects
#' @keywords internal
env_pkg_name <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  paste("package:", pkg$package, sep = "")
}

#' Generate name of package imports environment
#' Contains exported objects
#' @keywords internal
env_imports_name <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  paste("imports:", pkg$package, sep = "")
}


clear_classes <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  if (!is.loaded(pkg)) return()
  
  name <- env_pkg_name(pkg)
  classes <- getClasses(name)
  lapply(classes, removeClass, where = name)    
  invisible()
}

base_env <- function(pkg) {
  new.env(parent = emptyenv())
}
