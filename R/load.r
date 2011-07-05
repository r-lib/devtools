#' Load complete package.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param reset clear package environment and reset file cache before loading
#'   any pieces of the package.
#' 
#' @keywords programming
#' @export
load_all <- function(pkg = NULL, reset = FALSE) {
  pkg <- as.package(pkg)
  message("Loading ", pkg$package)
  
  # Check description file is ok
  check <- tools:::.check_package_description(
    file.path(pkg$path, "DESCRIPTION"))
  if (length(check) > 0) {
    msg <- capture.output(tools:::print.check_package_description(check))
    message("Invalid DESCRIPTION:\n", paste(msg, collapse = "\n"))
  }
  
  # If installed version of package loaded, unload it
  if (is.loaded(pkg) && is.locked(pkg)) {
    unload(pkg)
  }
  
  # Load dependencies before creating environment so it sees all the required
  # packages
  load_deps(pkg)

  if (reset) {
    clear_cache()
    clear_classes(pkg)
    clear_pkg_env(pkg)
  }
  
  env <- pkg_env(pkg)
  load_data(pkg, env)
  load_code(pkg, env)
  load_c(pkg)

  invisible()  
}


is.locked <- function(pkg = NULL) {
  environmentIsLocked(as.environment(env_name(pkg)))
}