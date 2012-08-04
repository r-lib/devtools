#' Generate an development environment for a package.
#'
#' \code{devtools} keeps the global workspace clean by loading all code and
#' data into a separate environment.  This environment is 
#' \code{\link{attach}}ed to the search path just after the global environment
#' so it will override loaded packages.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
pkg_ns_env <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  name <- env_ns_name(pkg)
  print(name)

  if (!is.loaded_ns(pkg)) {
    env <- makeNamespace(pkg$package)
    attr(env, 'name') <- name
  }

  env
}


#' Package development environment
#' Contains exported objects
#' @export
pkg_pkg_env <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  name <- env_pkg_name(pkg)
  
  if (!is.loaded_pkg(pkg)) {
    attach(new.env(parent = emptyenv()), name = name)
  }

  as.environment(name)
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

#' Generate name of package development environment
#' Contains exported objects
#' @keywords internal
env_pkg_name <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  paste("package:", pkg$package, sep = "")
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


# Took this from base::loadNamespace()
makeNamespace <- function(name, version = NULL, lib = NULL) {
  impenv <- new.env(parent = .BaseNamespaceEnv, hash = TRUE)
  attr(impenv, "name") <- paste("imports", name, sep = ":")
  env <- new.env(parent = impenv, hash = TRUE)
  name <- as.character(as.name(name))
  version <- as.character(version)
  info <- new.env(hash = TRUE, parent = baseenv())
  assign(".__NAMESPACE__.", info, envir = env)
  assign("spec", c(name = name, version = version), envir = info)
  setNamespaceInfo(env, "exports", new.env(hash = TRUE, 
      parent = baseenv()))
  dimpenv <- new.env(parent = baseenv(), hash = TRUE)
  attr(dimpenv, "name") <- paste("lazydata", name, sep = ":")
  setNamespaceInfo(env, "lazydata", dimpenv)
  setNamespaceInfo(env, "imports", list(base = TRUE))
  setNamespaceInfo(env, "path", normalizePath(file.path(lib, 
      name), "/", TRUE))
  setNamespaceInfo(env, "dynlibs", NULL)
  setNamespaceInfo(env, "S3methods", matrix(NA_character_, 
      0L, 3L))
  assign(".__S3MethodsTable__.", new.env(hash = TRUE, 
      parent = baseenv()), envir = env)
  .Internal(registerNamespace(name, env))
  env
}