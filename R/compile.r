#' Compile a .dll/.so from source
#'
#' Support for compiling C, C++, and Fotran code is experimental, and
#' will probably only work for simple cases where the code is to be
#' compiled into a single DLL. It will work with Makevars files, but
#' not with Makefiles.
#'
#' \code{compile_dll} will compile \code{.c}, \code{.cpp}, and \code{.f}
#' files, and save the resulting DLL file in the same directory as the
#' source code, \code{/src/}. Depending on the platform, the DLL file
#' will have the extension \code{.dll} or \code{.so}.
#'
#' Invisibly returns the names of the DLL.
#'
#' @note If this is used to compile code that uses Rcpp, you may need to
#'   add the following line to your \code{Makevars} file so that it
#'   knows where to find the Rcpp headers:
#'   \code{PKG_CPPFLAGS=`$(R_HOME)/bin/Rscript -e 'Rcpp:::CxxFlags()'`}
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @seealso \code{\link{clean_dll}} to delete the compiled files.
#' @export
compile_dll <- function(pkg = ".") {
  pkg <- as.package(pkg)

  # Check source dir exists
  srcdir <- file.path(pkg$path, "src")
  if (!dir.exists(srcdir))
    return(invisible())

  # Compile Rcpp attributes if necessary
  compile_rcpp_attributes(pkg)
  
  # Check that there are source files to compile
  srcfiles <- dir(srcdir, pattern = "\\.(c|cpp|f)$")
  if (length(srcfiles) == 0)
    return(invisible())
  # Compile the DLL using an approriately constructed build environment
  with_env(build_env_vars(pkg), {
    srcfiles <- paste(srcfiles, collapse = " ")
    R(paste("CMD SHLIB", "-o", basename(dll_name(pkg)), srcfiles),
      path = srcdir)
  })

  invisible(dll_name(pkg))
}

#' Remove compiled objects from /src/ directory
#'
#' Invisibly returns the names of the deleted files.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @seealso \code{\link{compile_dll}}
#' @export
clean_dll <- function(pkg = ".") {
  pkg <- as.package(pkg)

  # Clean out the /src/ directory
  files <- dir(file.path(pkg$path, "src"),
    pattern = "\\.(o|sl|so|dylib|a|dll|def)$",
    full.names = TRUE)
  unlink(files)

  invisible(files)
}

# Returns the full path and name of the DLL file
dll_name <- function(pkg = ".") {
  pkg <- as.package(pkg)

  name <- paste(pkg$package, .Platform$dynlib.ext, sep = "")

  file.path(pkg$path, "src", name)
}

# Get the build environment variables for a package:
#   - CLINK_CPPFLAGS with include paths (inst/include and LinkingTo)
#   - PKG_LIBS for Rcpp if it's a dependency
# Returns a named list of variables that can be passed to set_env
build_env_vars <- function(pkg) {

  # Environment variables to set for the build
  buildEnv <- list()

  # Include directories - start with the package inst/include directory then
  # add any packages found in LinkingTo
  includeDirs <- '-I"../inst/include"'
  linkingTo <- pkg_linking_to(pkg)
  includeDirs <- c(includeDirs, linking_to_includes(linkingTo))
  buildEnv$CLINK_CPPFLAGS <- paste(includeDirs, collapse = " ")

  # If the package depends on Rcpp then set PKG_LIBS as appropirate
  if (links_to_rcpp(pkg)) {  
    if (!require("Rcpp", quietly = TRUE)) 
      stop("Rcpp required for building this package")
    buildEnv$PKG_LIBS <- Rcpp:::RcppLdFlags()
  }

  # Return variables
  buildEnv
}


# Get the LinkingTo field of a package as a character vector
pkg_linking_to <- function(pkg) {
  parse_deps(pkg$linkingto)$name
}

# Build a list of include directories from a list of packages
linking_to_includes <- function(linkingTo) {
  includes <- character()
  for (package in linkingTo) {
    pkgPath <- find.package(package, NULL, quiet=TRUE)
    pkgIncludes <- paste0('-I"', pkgPath, .Platform$file.sep, 'include"')
    includes <- c(includes, pkgIncludes)
  }
  includes
}

