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
  setPackageName(pkg$package, env)
  # Create devtools metadata in namespace
  create_dev_meta(pkg$package)

  setNamespaceInfo(env, "path", pkg$path)
  setup_ns_imports(pkg)

  env
}

# This is taken directly from base::loadNamespace() in R 2.15.1.
# Except .Internal(registerNamespace(name, env)) is replaced by
# register_namespace(name, env)
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
  register_namespace(name, env)
  env
}


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
  # Update the exports metadata for the namespace with base::namespaceExport
  # It will throw warnings if objects are already listed in the exports
  # metadata, so catch those warnings and ignore them.
  suppressWarnings(namespaceExport(nsenv, exports))

  invisible()
}

# extracted from base::loadNamespace
add_classes_to_exports <- function(ns, package, exports, nsInfo) {
  if(.isMethodsDispatchOn() && .hasS4MetaData(ns) &&
    !identical(package, "methods") ) {
    ## cache generics, classes in this namespace (but not methods itself,
    ## which pre-cached at install time
    cacheMetaData(ns, TRUE, ns)
    ## load actions may have added objects matching patterns
    for (p in nsInfo$exportPatterns) {
      expp <- ls(ns, pattern = p, all.names = TRUE)
      newEx <- !(expp %in% exports)
      if(any(newEx))
        exports <- c(expp[newEx], exports)
    }
    ## process class definition objects
    expClasses <- nsInfo$exportClasses
    ##we take any pattern, but check to see if the matches are classes
    pClasses <- character()
    aClasses <- getClasses(ns)
    classPatterns <- nsInfo$exportClassPatterns
    ## defaults to exportPatterns
    if(!length(classPatterns))
      classPatterns <- nsInfo$exportPatterns
    for (p in classPatterns) {
      pClasses <- c(aClasses[grep(p, aClasses)], pClasses)
    }
    pClasses <- unique(pClasses)
    if( length(pClasses) ) {
      good <- vapply(pClasses, isClass, NA, where = ns)
      if( !any(good) && length(nsInfo$exportClassPatterns))
        warning(gettextf("'exportClassPattern' specified in 'NAMESPACE' but no matching classes in package %s", sQuote(package)),
          call. = FALSE, domain = NA)
      expClasses <- c(expClasses, pClasses[good])
    }
    if(length(expClasses)) {
      missingClasses <-
        !vapply(expClasses, isClass, NA, where = ns)
      if(any(missingClasses))
        stop(gettextf("in package %s classes %s were specified for export but not defined",
            sQuote(package),
            paste(expClasses[missingClasses],
              collapse = ", ")),
          domain = NA)
      expClasses <- paste0(classMetaName(""), expClasses)
    }
    ## process methods metadata explicitly exported or
    ## implied by exporting the generic function.
    allGenerics <- unique(c(.getGenerics(ns),
        .getGenerics(parent.env(ns))))
    expMethods <- nsInfo$exportMethods
    ## check for generic functions corresponding to exported methods
    addGenerics <- expMethods[is.na(match(expMethods, exports))]
    if(length(addGenerics)) {
      nowhere <- sapply(addGenerics, function(what) !exists(what, mode = "function", envir = ns))
      if(any(nowhere)) {
        warning(gettextf("no function found corresponding to methods exports from %s for: %s",
            sQuote(package),
            paste(sQuote(sort(unique(addGenerics[nowhere]))), collapse = ", ")),
          domain = NA, call. = FALSE)
        addGenerics <- addGenerics[!nowhere]
      }
      if(length(addGenerics)) {
        ## skip primitives
        addGenerics <- addGenerics[sapply(addGenerics, function(what) ! is.primitive(get(what, mode = "function", envir = ns)))]
        ## the rest must be generic functions, implicit or local
        ## or have been cached via a DEPENDS package
        ok <- sapply(addGenerics, .findsGeneric, ns)
        if(!all(ok)) {
          bad <- sort(unique(addGenerics[!ok]))
          msg <-
            ngettext(length(bad),
              "Function found when exporting methods from the namespace %s which is not S4 generic: %s",
              "Functions found when exporting methods from the namespace %s which are not S4 generic: %s", domain = "R-base")
          stop(sprintf(msg, sQuote(package),
              paste(sQuote(bad), collapse = ", ")),
            domain = NA, call. = FALSE)
        }
        else if(any(ok > 1L)) #from the cache, don't add
          addGenerics <- addGenerics[ok < 2L]
      }
      ### <note> Uncomment following to report any local generic functions
      ### that should have been exported explicitly. But would be reported
      ### whenever the package is loaded, which is not when it is relevant.
      ### </note>
      ## local <- sapply(addGenerics, function(what) identical(as.character(get(what, envir = ns)@package), package))
      ## if(any(local))
      ## message(gettextf("export(%s) from package %s generated by exportMethods()",
      ## paste(addGenerics[local], collapse = ", ")),
      ## domain = NA)
      exports <- c(exports, addGenerics)
    }
    expTables <- character()
    if(length(allGenerics)) {
      expMethods <-
        unique(c(expMethods,
            exports[!is.na(match(exports, allGenerics))]))
      missingMethods <- !(expMethods %in% allGenerics)
      if(any(missingMethods))
        stop(gettextf("in %s methods for export not found: %s",
            sQuote(package),
            paste(expMethods[missingMethods],
              collapse = ", ")),
          domain = NA)
      tPrefix <- .TableMetaPrefix()
      allMethodTables <-
        unique(c(.getGenerics(ns, tPrefix),
            .getGenerics(parent.env(ns), tPrefix)))
      needMethods <-
        (exports %in% allGenerics) & !(exports %in% expMethods)
      if(any(needMethods))
        expMethods <- c(expMethods, exports[needMethods])
      ## Primitives must have their methods exported as long
      ## as a global table is used in the C code to dispatch them:
      ## The following keeps the exported files consistent with
      ## the internal table.
      pm <- allGenerics[!(allGenerics %in% expMethods)]
      if(length(pm)) {
        prim <- logical(length(pm))
        for(i in seq_along(prim)) {
          f <- getFunction(pm[[i]], FALSE, FALSE, ns)
          prim[[i]] <- is.primitive(f)
        }
        expMethods <- c(expMethods, pm[prim])
      }
      for(i in seq_along(expMethods)) {
        mi <- expMethods[[i]]
        if(!(mi %in% exports) &&
          exists(mi, envir = ns, mode = "function",
            inherits = FALSE))
          exports <- c(exports, mi)
        pattern <- paste0(tPrefix, mi, ":")
        ii <- grep(pattern, allMethodTables, fixed = TRUE)
        if(length(ii)) {
          if(length(ii) > 1L) {
            warning(gettextf("multiple methods tables found for %s",
                sQuote(mi)), call. = FALSE, domain = NA)
            ii <- ii[1L]
          }
          expTables[[i]] <- allMethodTables[ii]
        }
        else { ## but not possible?
          warning(gettextf("failed to find metadata object for %s",
              sQuote(mi)), call. = FALSE, domain = NA)
        }
      }
    }
    else if(length(expMethods))
      stop(gettextf("in package %s methods %s were specified for export but not defined",
          sQuote(package),
          paste(expMethods, collapse = ", ")),
        domain = NA)
    exports <- unique(c(exports, expClasses, expTables))
  }  
 
  exports
}
environment(add_classes_to_exports) <- asNamespace("methods")

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

# This is similar to getNamespace(), except that getNamespace will load
# the namespace if it's not already loaded. This function will not.
# In R 2.16, a function called .getNamespace() will have the same effect
# and this will no longer be necessary.
get_namespace <- function(name) {
  # Sometimes we'll be passed something like as.name(name), so make sure
  # it's a string
  name <- as.character(name)
  if (!(name %in% loadedNamespaces()))
    return(NULL)
  else
    return(getNamespace(name))
}
