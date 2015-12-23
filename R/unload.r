#' Unload a package
#'
#' This function attempts to cleanly unload a package, including unloading
#' its namespace, deleting S4 class definitions and unloading any loaded
#' DLLs. Unfortunately S4 classes are not really designed to be cleanly
#' unloaded, and so we have to manually modify the class dependency graph in
#' order for it to work - this works on the cases for which we have tested
#' but there may be others.  Similarly, automated DLL unloading is best tested
#' for simple scenarios (particularly with \code{useDynLib(pkgname)} and may
#' fail in other cases. If you do encounter a failure, please file a bug report
#' at \url{http://github.com/hadley/devtools/issues}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#'
#' @examples
#' \dontrun{
#' # Unload package that is in current directory
#' unload(".")
#'
#' # Unload package that is in ./ggplot2/
#' unload("ggplot2/")
#'
#' # Can use inst() to find the path of an installed package
#' # This will load and unload the installed ggplot2 package
#' library(ggplot2)
#' unload(inst("ggplot2"))
#' }
#' @export
unload <- function(pkg = ".") {
  pkg <- as.package(pkg)

  ns <- asNamespace(pkg$package)

  unregister_S3_methods(ns)

  # If the package was loaded with devtools, any s4 classes that were created
  # by the package need to be removed in a special way.
  if (!is.null(dev_meta(pkg$package))) {
    remove_s4_classes(pkg)
  }


  if (pkg$package %in% loadedNamespaces()) {
    # unloadNamespace will throw an error if it has trouble unloading.
    # This can happen when there's another package that depends on the
    # namespace.
    # unloadNamespace will also detach the package if it's attached.
    #
    # unloadNamespace calls onUnload hook and .onUnload
    try(unloadNamespace(pkg$package), silent = TRUE)

  } else {
    stop("Package ", pkg$package, " not found in loaded packages or namespaces")
  }

  # Sometimes the namespace won't unload with detach(), like when there's
  # another package that depends on it. If it's still around, force it
  # to go away.
  # loadedNamespaces() and unloadNamespace() often don't work here
  # because things can be in a weird state.
  if (!is.null(.getNamespace(pkg$package))) {
    message("unloadNamespace(\"", pkg$package,
      "\") not successful. Forcing unload.")
    unregister_namespace(pkg$package)
  }

  # Clear so that loading the package again will re-read all files
  clear_cache()

  # Do this after detach, so that packages that have an .onUnload function
  # which unloads DLLs (like MASS) won't try to unload the DLL twice.
  unload_dll(pkg)
}

unregister_S3_methods <- function(ns) {
  S3_methods <- getNamespaceInfo(ns, "S3methods")

  unregister <- function(name, class, method) {
    # This code was adapted from the .registerS3method internal function of
    # base::registerS3methods
    # https://github.com/wch/r-source/blob/05b76baa411afd3e9d0f3fc3c09a9a252a0a9100/src/library/base/R/namespace.R#L1398-L1426
    env <-
      if (!is.na(x <- .knownS3Generics[name])) {
        asNamespace(x)
      } else {
        if(is.null(genfun <- get0(name, envir = ns))) {
          stop(sprintf("object '%s' not found while unloading namespace '%s'",
               name, getNamespaceName(ns)), call. = FALSE)
        }
        if(.isMethodsDispatchOn() && methods::is(genfun, "genericFunction")) {
          genfun <- genfun@default  # nearly always, the S3 generic
        }
        if (typeof(genfun) == "closure") {
          environment(genfun)
        } else {
          baseenv()
        }
      }
    table <- get(".__S3MethodsTable__.", envir = env, inherits = FALSE)
    rm(list = method, envir = table)
  }
  for (i in seq_len(NROW(S3_methods))) {
    unregister(S3_methods[i, 1], S3_methods[i, 2], S3_methods[i, 3])
  }
}

# This unloads dlls loaded by either library() or load_all()
unload_dll <- function(pkg = ".") {
  pkg <- as.package(pkg)

  # Always run garbage collector to force any deleted external pointers to
  # finalise
  gc()

  # Special case for devtools - don't unload DLL because we need to be able
  # to access nsreg() in the DLL in order to run makeNamespace. This means
  # that changes to compiled code in devtools can't be reloaded with
  # load_all -- it requires a reinstallation.
  if (pkg$package == "devtools") {
    return(invisible())
  }

  pkglibs <- loaded_dlls(pkg)

  for (lib in pkglibs) {
    dyn.unload(lib[["path"]])
  }

  # Remove the unloaded dlls from .dynLibs()
  libs <- .dynLibs()
  .dynLibs(libs[!(libs %in% pkglibs)])

  invisible()
}
