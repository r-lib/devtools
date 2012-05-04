#' Install a local development package.
#'
#' Uses \code{R CMD INSTALL} to install the package. Will also try to install
#' dependencies of the package from CRAN, if they're not already installed.
#'
#' Installation takes place on a copy of the package produced by 
#' \code{R CMD build} to avoid modifying the local directory in any way.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param reload if \code{TRUE} (the default), will automatically reload the 
#'   package after installing.
#' @param quick if \code{TRUE} skips docs, multiple-architectures,
#'   and demos to make installation as fast as possible.
#' @param args An optional character vector of additional command line
#'   arguments to be passed to \code{R CMD install}.
#' @export
#' @family package installation
#' @importFrom utils install.packages
install <- function(pkg = NULL, reload = TRUE, quick = FALSE, args = NULL) {
  pkg <- as.package(pkg)
  message("Installing ", pkg$package)
  install_deps(pkg)  
  
  built_path <- build(pkg, tempdir())
  on.exit(unlink(built_path))    
  
  opts <- paste("--library=", shQuote(.libPaths()[1]), sep = "")
  if (quick) {
    opts <- paste(opts, "--no-docs", "--no-multiarch", "--no-demo")
  }
  opts <- paste(opts, paste(args, collapse = " "))
  
  R(paste("CMD INSTALL ", shQuote(built_path), " ", opts, sep = ""))

  if (reload) reload(pkg)
  invisible(TRUE)
}

install_deps <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  deps <- c(parse_deps(pkg$depends), parse_deps(pkg$imports), 
    parse_deps(pkg$linkingto))
  
  # Remove packages that are already installed
  not.installed <- function(x) length(find.package(x, quiet = TRUE)) == 0
  deps <- Filter(not.installed, deps)
  
  if (length(deps) == 0) return(invisible())
  
  message("Installing dependencies for ", pkg$package, ":\n", 
    paste(deps, collapse = ", "))
  install.packages(deps)
  invisible(deps)
}



#' @rdname install
#' @description
#' \code{install_debug}  will install the package with debugging
#' compilation flags set.
#' \code{PKG_CXXFLAGS="-Wall -pedantic -g -O0"}
#' @export
install_debug <- function(pkg = NULL, reload = TRUE, ...) {
  old_PKG_CXXFLAGS <- Sys.getenv("PKG_CXXFLAGS")
  Sys.setenv(PKG_CXXFLAGS="-UNDEBUG -Wall -pedantic -g -O0")
  install(pkg=pkg, reload=TRUE, ...)
  Sys.setenv(PKG_CXXFLAGS=old_PKG_CXXFLAGS)
}

