#' Return the namespace environment for a package.
#'
#' Contains all (exported and non-exported) objects, and is a descendent of
#' \code{R_GlobalEnv}. The hieararchy is \code{<namespace:pkg>},
#' \code{<imports:pkg>}, \code{<namespace:base>}, and then
#' \code{R_GlobalEnv}.
#'
#' If the package is not loaded, this function returns \code{NULL}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @keywords internal
#' @seealso \code{\link{pkg_env}} for the attached environment that
#'   contains the exported objects.
#' @seealso \code{\link{imports_env}} for the environment that contains
#'   imported objects for the package.
#' @export
ns_env <- function(pkg = ".") {
  pkg <- as.package(pkg)

  if (!is_loaded(pkg)) return(NULL)

  asNamespace(pkg$package)
}


# Create the namespace environment for a package
create_ns_env <- function(pkg = ".") {
  pkg <- as.package(pkg)

  if (is_loaded(pkg)) {
    stop("Namespace for ", pkg$package, " already exists.")
  }

  env <- makeNamespace(pkg$package, pkg$version)
  methods::setPackageName(pkg$package, env)
  # Create devtools metadata in namespace
  create_dev_meta(pkg$package)

  setNamespaceInfo(env, "path", pkg$path)
  setup_ns_imports(pkg)

  env
}

# This is taken directly from base::loadNamespace()
delayedAssign("makeNamespace",
  eval(
    extract_lang(body(loadNamespace),
    function(x) length(x) > 2 && identical(x[1:2], quote(makeNamespace <- NULL)[1:2]))[[c(1, 3)]])
)

# Read the NAMESPACE file and set up the imports metdata.
# (which is stored in .__NAMESPACE__.)
setup_ns_imports <- function(pkg = ".") {
  pkg <- as.package(pkg)
  nsInfo <- parse_ns_file(pkg)
  setNamespaceInfo(pkg$package, "imports", nsInfo$imports)
}


# Read the NAMESPACE file and set up the exports metdata. This must be
# run after all the objects are loaded into the namespace because
# namespaceExport throw errors if the objects are not present.
setup_ns_exports <- function(pkg = ".", export_all = FALSE) {
  pkg <- as.package(pkg)
  nsInfo <- parse_ns_file(pkg)
  nsenv <- ns_env(pkg)

  if (export_all) {
    exports <- ls(nsenv, all.names = TRUE)
    # Make sure to re-export objects that are imported from other packages but
    # not copied.
    exports <- union(exports, nsInfo$exports)

    # List of things to ignore is from loadNamespace. There are also a
    # couple things to ignore from devtools.
    ignoreidx <- exports %in% c( ".__NAMESPACE__.",
      ".__S3MethodsTable__.", ".packageName", ".First.lib", ".onLoad",
      ".onAttach", ".conflicts.OK", ".noGenerics",
      ".__DEVTOOLS__", ".cache")
    exports <- exports[!ignoreidx]

  } else {
    # This code is from base::loadNamespace
    exports <- nsInfo$exports
    for (p in nsInfo$exportPatterns)
      exports <- c(ls(nsenv, pattern = p, all.names = TRUE), exports)
    exports <- add_classes_to_exports(ns = nsenv, package = pkg$package,
      exports = exports, nsInfo = nsInfo)
  }

  # Don't try to export objects that are missing from the namespace and imports
  ns_and_imports <- c(ls(nsenv, all.names = TRUE),
                      ls(imports_env(pkg), all.names = TRUE))
  extra_exports <- setdiff(exports, ns_and_imports)

  if (length(extra_exports) > 0) {
    warning("Objects listed as exports, but not present in namespace: ",
            paste(extra_exports, collapse = ", "))
    exports <- intersect(ns_and_imports, exports)
  }
  # Update the exports metadata for the namespace with base::namespaceExport
  # It will throw warnings if objects are already listed in the exports
  # metadata, so catch those warnings and ignore them.
  suppressWarnings(namespaceExport(nsenv, exports))

  invisible()
}

search_method_dispatch_on <- function(x) {
  is.call(x) && identical(x[[1L]], as.symbol("if")) &&
    identical(x[[2]], quote(.isMethodsDispatchOn() && .hasS4MetaData(ns) && !identical(package, "methods")))
}

#' Lookup S4 classes for export
#'
#' This function uses code from base::loadNamespace. Previously this code was
#' copied directly, now it is dynamically looked up instead, to prevent drift as
#' base::loadNamespace changes.
delayedAssign("add_classes_to_exports",
  make_function(alist(ns =, package =, exports =, nsInfo =),
    call("{",
      extract_lang(
        modify_lang(body(base::loadNamespace), strip_internal_calls, "methods"),
        search_method_dispatch_on)[[1]],
      quote(exports)),
    asNamespace("methods")))

#' Parses the NAMESPACE file for a package
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @examples
#' if (has_tests()) {
#' parse_ns_file(devtest("testLoadHooks"))
#' }
#' @keywords internal
#' @export
parse_ns_file <- function(pkg = ".") {
  pkg <- as.package(pkg)

  parseNamespaceFile(basename(pkg$path), dirname(pkg$path),
    mustExist = FALSE)
}


# Register the S3 methods for this package
register_s3 <- function(pkg = ".") {
  pkg <- as.package(pkg)
  nsInfo <- parse_ns_file(pkg)

  # Adapted from loadNamespace
  registerS3methods(nsInfo$S3methods, pkg$package, ns_env(pkg))
}


# Reports whether a package is loaded into a namespace. It may be
# attached or not attached.
is_loaded <- function(pkg = ".") {
  pkg <- as.package(pkg)
  pkg$package %in% loadedNamespaces()
}


# Returns the namespace registry
#' @useDynLib devtools nsreg
ns_registry <- function() {
  .Call(nsreg)
}


# Register a namespace
register_namespace <- function(name = NULL, env = NULL) {
  # Be careful about what we allow
  if (!is.character(name) || name == "" || length(name) != 1)
    stop("'name' must be a non-empty character string.")

  if (!is.environment(env))
    stop("'env' must be an environment.")

  if (name %in% loadedNamespaces())
    stop("Namespace ", name, " is already registered.")

  # Add the environment to the registry
  nsr <- ns_registry()
  nsr[[name]] <- env

  env
}


# unregister a namespace - should be used only if unloadNamespace()
# fails for some reason
unregister_namespace <- function(name = NULL) {
  # Be careful about what we allow
  if (!is.character(name) || name == "" || length(name) != 1)
    stop("'name' must be a non-empty character string.")

  if (!(name %in% loadedNamespaces()))
    stop(name, " is not a registered namespace.")

  # Remove the item from the registry
  do.call(rm, args = list(name, envir = ns_registry()))
  invisible()
}
