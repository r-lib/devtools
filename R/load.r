#' Load complete package.
#'
#' \code{load_all} loads a package. It roughly simulates what happens
#' when a package is installed and loaded with \code{\link{library}}.
#'
#' To unload and reload a package, use \code{reset=TRUE}.
#' When reloading a package, A, that another package, B, depends on,
#' \code{load_all} might not be able to cleanly unload and reload A.
#' If this causes problems, try using unloading package B with
#' \code{\link{unload}} before using \code{load_all} on A.
#'
#' Support for packages with compiled C/C++/Fortran code in the
#' \code{/src/} directory is experimental. See \code{\link{compile_dll}}
#' for more information about compiling code.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param reset clear package environment and reset file cache before loading
#'   any pieces of the package.
#' @param recompile force a recompile of DLL from source code, if present.
#' @param self For internal use only. (This is used when \code{load_all}
#'   is called from \code{\link{reload_devtools}})
#' 
#' @keywords programming
#' @export
load_all <- function(pkg = NULL, reset = FALSE, recompile = FALSE,
  self = FALSE) {

  pkg <- as.package(pkg)

  # Reloading devtools is a special case
  if (pkg$package == "devtools" && self == FALSE) {
    out <- reload_devtools(pkg, reset)
    return(invisible(out))
  } else {
    message("Loading ", pkg$package)
  }

  
  # Check description file is ok
  check <- tools:::.check_package_description(
    file.path(pkg$path, "DESCRIPTION"))
  if (length(check) > 0) {
    msg <- capture.output(tools:::print.check_package_description(check))
    message("Invalid DESCRIPTION:\n", paste(msg, collapse = "\n"))
  }
  
  # If installed version of package loaded, unload it
  if (is.loaded_ns(pkg) && is.null(dev_meta(pkg$package))) {
    unload(pkg)
  }

  # Unload dlls
  unload_dll(pkg)
  
  if (reset) {
    clear_cache()
    clear_pkg_env(pkg)
  }

  if (recompile) clean_dll(pkg)

  # Compile dll if it exists
  compile_dll(pkg)


  # Set up the namespace environment ----------------------------------
  nsenv <- ns_env(pkg, create = TRUE)

  out <- list(env = nsenv)

  # Load dependencies into the imports environment
  load_imports(pkg)

  out$data <- load_data(pkg)
  out$code <- load_code(pkg)
  out$dll <- load_dll(pkg)

  # Set up the exports in the namespace metadata (this must happen after
  # the objects are loaded)
  setup_ns_exports(pkg)

  run_onload(pkg)

  # Set up the package environment ------------------------------------
  # Create the package environment and copy over objects from the
  # namespace environment.
  attach_ns(pkg)

  run_onattach(pkg)

  invisible(out)  
}


is.locked <- function(pkg = NULL) {
  environmentIsLocked(as.environment(env_pkg_name(pkg)))
}
