#' Generate a namespace environment for a package.
#'
#' Contains all (exported and non-exported) objects, and is a descendent of
#' \code{R_GlobalEnv}. The hieararchy is \code{<namespace:pkg>}, 
#' \code{<imports:pkg>}, \code{<namespace:base>}, and then
#' \code{R_GlobalEnv}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords programming
#' @export
ns_env <- function(pkg = NULL) {
  pkg <- as.package(pkg)

  if (!is_loaded(pkg)) return(NULL)

  asNamespace(pkg$package)
}


# Create the namespace environment for a package
create_ns_env <- function(pkg = NULL) {
  pkg <- as.package(pkg)

  if (is_loaded(pkg)) {
    stop("Namespace for ", pkg$package, " already exists.")
  }

  env <- makeNamespace(pkg$package)
  setPackageName(pkg$package, env)
  # Create devtools metadata in namespace
  dev_meta(pkg$package, create = TRUE)

  setNamespaceInfo(env, "path", pkg$path)
  setup_ns_imports(pkg)

  env
}

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
  # metadata, so catch those warnings and ignore them.
  suppressWarnings(namespaceExport(ns_env(pkg), exports))

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


register_s3 <- function(pkg) {
  pkg <- as.package(pkg)
  nsInfo <- parse_ns_file(pkg)

  # Adapted from loadNamespace
  registerS3methods(nsInfo$S3methods, pkg$package, ns_env(pkg))
}
