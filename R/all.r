#' Load complete package.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param reset clear package environment and reset file cache before loading
#'   any pieces of the package.
#' 
#' @keywords programming
#' @export
load_all <- function(pkg, reset = FALSE) {
  pkg <- as.package(pkg)

  if (reset) {
    clear_cache()
    clear_pkg_env(pkg)
  }
  
  # Load dependencies before creating environment so it sees all the required
  # packages
  load_deps(pkg)
  env <- pkg_env(pkg)
  
  load_data(pkg, env)
  load_code(pkg, env)
  load_c(pkg)

  invisible()  
}


