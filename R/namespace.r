# This is taken directly from base::loadNamespace() in R 2.15.1
makeNamespace <- function(name, version = NULL, lib = NULL) {
  impenv <- new.env(parent = .BaseNamespaceEnv, hash = TRUE)
  attr(impenv, "name") <- paste("imports", name, sep = ":")
  env <- new.env(parent = impenv, hash = TRUE)
  name <- as.character(as.name(name))
  version <- as.character(version)
  info <- new.env(hash = TRUE, parent = baseenv())
  assign(".__NAMESPACE__.", info, envir = env)
  assign("spec", c(name = name, version = version), envir = info)
  setNamespaceInfo(env, "exports", new.env(hash = TRUE, parent = baseenv()))
  dimpenv <- new.env(parent = baseenv(), hash = TRUE)
  attr(dimpenv, "name") <- paste("lazydata", name, sep = ":")
  setNamespaceInfo(env, "lazydata", dimpenv)
  setNamespaceInfo(env, "imports", list(base = TRUE))
  setNamespaceInfo(env, "path", normalizePath(file.path(lib, name), "/", TRUE))
  setNamespaceInfo(env, "dynlibs", NULL)
  setNamespaceInfo(env, "S3methods", matrix(NA_character_, 0L, 3L))
  assign(".__S3MethodsTable__.", new.env(hash = TRUE, parent = baseenv()), envir = env)
  .Internal(registerNamespace(name, env))
  env
}


# Read the NAMESPACE file and set up the imports metdata.
# (which is stored in .__NAMESPACE__.)
setup_ns_imports <- function(pkg) {
  nsInfo <- parse_ns_file(pkg)
  setNamespaceInfo(pkg$package, "imports", nsInfo$imports)
}


# Read the NAMESPACE file and set up the exports metdata. This must be
# run after all the objects are loaded into the namespace because
# namespaceExport throw errors if the objects are not present.
setup_ns_exports <- function(pkg) {
  nsInfo <- parse_ns_file(pkg)

  # This code is from base::loadNamespace
  exports <- nsInfo$exports
  for (p in nsInfo$exportPatterns)
    exports <- c(ls(env, pattern = p, all.names = TRUE), exports)

  # Update the exports metadata for the namespace with base::namespaceExport
  # It will throw warnings if objects are already listed in the exports
  # metadata, so catch those errors and ignore them.
  tryCatch(
    namespaceExport(ns_env(pkg), exports),
    warning = function(w) NULL)

  invisible()
}


#' Parses the NAMESPACE file for a package
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @examples
#' parse_ns_file(devtest("load-hooks"))
#' @export
parse_ns_file <- function(pkg) {
  pkg <- as.package(pkg)

  parseNamespaceFile(basename(pkg$path), dirname(pkg$path),
    mustExist = FALSE)
}


# Create the package environment and copy over objects from the
# namespace environment
attach_ns <- function(pkg, export_all = TRUE) {
  pkg <- as.package(pkg)
  nsenv <- ns_env(pkg)
  pkgenv <- pkg_env(pkg, create = TRUE)

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
