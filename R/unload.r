#' Unload a package
#'
#' This function attempts to cleanly unload a package, including unloading
#' it's namespace, deleting S4 class definitions and unloading any loaded
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

  # This is a hack to work around unloading devtools itself. The unloading
  # process normally makes other devtools functions inaccessible,
  # resulting in "Error in unload(pkg) : internal error -3 in R_decompress1".
  # If we simply access them here using as.list (without calling them), then
  # they will remain available for use later.
  if (pkg$package == "devtools") {
    as.list(ns_env(pkg))
  }

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

# This unloads dlls loaded by either library() or load_all()
unload_dll <- function(pkg = ".") {
  pkg <- as.package(pkg)

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
