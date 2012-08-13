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


# Read the NAMESPACE file and set up some of the namespace info
# (which is stored in .__NAMESPACE__.)
setup_ns_info <- function(pkg) {
  nsInfo <- parse_ns_file(pkg)
  setNamespaceInfo(pkg$package, "imports", nsInfo$imports)
  setNamespaceInfo(pkg$package, "exports", nsInfo$exports)
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
