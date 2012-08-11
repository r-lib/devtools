#' Load complete package.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param reset clear package environment and reset file cache before loading
#'   any pieces of the package.
#' @param self For internal use only. (This is used when \code{load_all}
#'   is called from \code{\link{reload_devtools}})
#' 
#' @keywords programming
#' @export
load_all <- function(pkg = NULL, reset = FALSE, self = FALSE) {
  pkg <- as.package(pkg)

  # Reloading devtools is a special case
  if (pkg$package == "devtools" && self == FALSE) {
    reload_devtools(pkg, reset)
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
  if (is.loaded(pkg) && is.null(dev_meta(pkg$package))) {
    unload(pkg)
  }
  
  if (reset) {
    clear_cache()
    clear_classes(pkg)
    clear_pkg_env(pkg)
  }

  # Create the namespace environment
  # namspace:xx is a child of imports:xx is a child of namespace:base
  # is a child of R_GlobalEnv
  nsenv <- ns_env(pkg, create = TRUE)

  out <- list(env = nsenv)

  # Load dependencies into the imports environment
  load_imports(pkg)

  out$data <- load_data(pkg)
  out$code <- load_code(pkg)
  out$c <- load_c(pkg)

  run_onload(pkg)

  # Copy all the objects from namespace env to package env, so that they
  # are visible in global env.
  copy_env(nsenv, pkg_env(pkg, create = TRUE),
    ignore = c(".__NAMESPACE__.", ".__S3MethodsTable__.",
      ".packageName", ".First.lib", ".onLoad", ".onAttach",
      ".conflicts.OK", ".noGenerics"))

  run_onattach(pkg)

  invisible(out)  
}


is.locked <- function(pkg = NULL) {
  environmentIsLocked(as.environment(env_pkg_name(pkg)))
}
