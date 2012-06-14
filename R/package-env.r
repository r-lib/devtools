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
pkg_env <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  name <- env_name(pkg)
  
  if (!is.loaded(pkg)) {
    attach(base_env(pkg), name = name)
  }
  
  # if (is.loaded(pkg)) return(as.environment(name))
  # 
  # # Set up package environments ----------------------------------------------
  # imp_env <- new.env(parent = .BaseNamespaceEnv, hash = TRUE)
  # attr(imp_env, "name") <- paste("imports", pkg$package, sep = ":")
  # 
  # env <- new.env(parent = imp_env, hash = TRUE)
  # env$.packageName <- pkg$package
  # 
  # ns_env <- new.env(hash = TRUE, parent = baseenv())
  # ns_env[["spec"]] <- c(name = pkg$package, version = pkg$version)
  # env[[".__NAMESPACE__."]] <- ns_env
  # 
  # setNamespaceInfo(env, "exports", new.env(hash = TRUE, parent = baseenv()))
  # setNamespaceInfo(env, "imports", list("base" = TRUE))
  # setNamespaceInfo(env, "path", pkg$path)
  # setNamespaceInfo(env, "dynlibs", NULL)
  # setNamespaceInfo(env, "S3methods", matrix(NA_character_, 0L, 3L))
  # env[[".__S3MethodsTable__."]] <- new.env(hash = TRUE, parent = baseenv())
  # 
  # dimpenv <- new.env(parent = baseenv(), hash = TRUE)
  # attr(dimpenv, "name") <- paste("lazydata", pkg$package, sep=":")
  # setNamespaceInfo(env, "lazydata", dimpenv)
  # 
  # # Set up imports -----------------------------------------------------------
  # nsInfo <- parseNamespaceFile(basename(pkg$path), dirname(pkg$path))
  # 
  # for (i in nsInfo$imports) {
  #   if (is.character(i)) {
  #     namespaceImport(env, loadNamespace(i))
  #   } else {
  #     namespaceImportFrom(env, loadNamespace(i[[1L]]), i[[2L]])
  #   }
  # }
  # for(imp in nsInfo$importClasses) {
  #   namespaceImportClasses(env, loadNamespace(imp[[1L]]), imp[[2L]])
  # }
  # for(imp in nsInfo$importMethods) {
  #   namespaceImportMethods(env, loadNamespace(imp[[1L]]), imp[[2L]])
  # }
  
  as.environment(name)
}

#' Detach development environment
#' @keywords internal
clear_pkg_env <- function(pkg = NULL) {
  
  if (is.loaded(pkg)) {
    unload(pkg)
  }  
}

#' Generate name of package development environment
#' @keywords internal
env_name <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  paste("package:", pkg$package, sep = "")
}

clear_classes <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  if (!is.loaded(pkg)) return()
  
  name <- env_name(pkg)
  classes <- getClasses(name)
  lapply(classes, removeClass, where = name)    
  invisible()
}

base_env <- function(pkg) {
  new.env(parent = emptyenv())
}
