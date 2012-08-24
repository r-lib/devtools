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
  # process normally makes clear_cache and unload_dll inaccessible,
  # resulting in "Error in unload(pkg) : internal error -3 in R_decompress1",
  # but if we simply evaluate them here (without calling them), then they
  # will remain available for use later in this function.
  if (pkg$package == "devtools") {
    clear_cache
    unload_dll
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
  if (!is.null(.Internal(getRegisteredNamespace(pkg$package)))) {
    message("unloadNamespace(\"", pkg$package,
      "\") not successful. Forcing unload.")
    .Internal(unregisterNamespace(pkg$package))
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
  libs <- .dynLibs()

  # Get all dlls whose name matches this package
  # (can be more than one)
  matchidx <- vapply(libs, "[[", character(1), "name") == pkg$package

  for (matchlib in libs[matchidx]) {
    dyn.unload(matchlib[["path"]])
  }

  # Remove the unloaded dlls from .dynLibs()
  .dynLibs(libs[!matchidx])

  invisible()
}
