#' Unload and reload package.
#' 
#' If the package is not loaded already, this does nothing.
#' 
#' See the caveats in \code{\link{detach}} for the many reasons why this 
#' might not work. If in doubt, quit R and restart.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @examples
#' \dontrun{
#' # Reload package that is in current directory
#' reload(".")
#'
#' # Reload package that is in ./ggplot2/
#' reload("ggplot2/")
#'
#' # Can use inst() to find the package path
#' # This will reload the installed ggplot2 package
#' reload(inst("ggplot2"))
#' }
#' @export
reload <- function(pkg = ".") {
  pkg <- as.package(pkg)
  
  if (is_attached(pkg)) {
    message("Reloading installed ", pkg$package)
    unload(pkg)
    require(pkg$package, character.only = TRUE, quietly = TRUE)
  }
}

#' Unload a package
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

  if (pkg$package %in% loadedNamespaces()) {
    # unloadNamespace will throw an error if it has trouble unloading.
    # This can happen when there's another package that depends on the
    # namespace.
    # unloadNamespace will also detach the package if it's attached.
    try(unloadNamespace(pkg$package), silent = TRUE)

  } else {
    stop("Package ", pkg$package, " not found in loaded packages or namespaces")
  }

  # Sometimes the namespace won't unload with detach(), like when there's
  # another package that depends on it. If it's still around, force it
  # to go away.
  # loadedNamespaces() and unloadNamespace() often don't work here
  # because things can be in a weird state.
  if (!is.null(get_namespace(pkg$package))) {
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
