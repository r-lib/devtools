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
#' @seealso \code{\link{with_debug}} to install packages with debugging flags
#'   set.
#' @importFrom utils install.packages
install <- function(pkg = ".", reload = TRUE, quick = FALSE, args = NULL) {
  pkg <- as.package(pkg)
  message("Installing ", pkg$package)
  install_deps(pkg)  
  
  built_path <- build(pkg, tempdir())
  on.exit(unlink(built_path))    
  
  opts <- c(
    paste("--library=", shQuote(.libPaths()[1]), sep = ""),
    "--with-keep.source")
  if (quick) {
    opts <- c(opts, "--no-docs", "--no-multiarch", "--no-demo")
  }
  opts <- paste(paste(opts, collapse = " "), paste(args, collapse = " "))
  
  R(paste("CMD INSTALL ", shQuote(built_path), " ", opts, sep = ""))

  if (reload) reload(pkg)
  invisible(TRUE)
}

install_deps <- function(pkg = ".") {
  pkg <- as.package(pkg)
  deps <- c(parse_deps(pkg$depends)$name, parse_deps(pkg$imports)$name, 
    parse_deps(pkg$linkingto)$name)
  
  # Remove packages that are already installed
  not.installed <- function(x) length(find.package(x, quiet = TRUE)) == 0
  deps <- Filter(not.installed, deps)
  
  if (length(deps) == 0) return(invisible())
  
  message("Installing dependencies for ", pkg$package, ":\n", 
    paste(deps, collapse = ", "))
  install.packages(deps)
  invisible(deps)
}

#' Temporarily set debugging compilation flags.
#'
#' @param code to execute.
#' @param PKG_CFLAGS flags for compiling C code
#' @param PKG_CXXFLAGS flags for compiling C++ code
#' @param PKG_FFLAGS flags for compiling Fortran code.
#' @param PKG_FCFLAGS flags for Fortran 9x code. 
#' @export
#' @examples
#' \dontrun{
#' install("mypkg")
#' with_debug(install("mypkg"))
#' }
with_debug <- function(code,
                       PKG_CFLAGS   = "-UNDEBUG -Wall -pedantic -g -O0",
                       PKG_CXXFLAGS = "-UNDEBUG -Wall -pedantic -g -O0", 
                       PKG_FFLAGS   = "-g -O0", 
                       PKG_FCFLAGS  = "-g -O0") {
  flags <- c(
    PKG_CFLAGS = PKG_CFLAGS, PKG_CXXFLAGS = PKG_CXXFLAGS,
    PKG_FFLAGS = PKG_FFLAGS, PKG_FCFLAGS = PKG_FCFLAGS)
  
  with_env(flags, code)
}

