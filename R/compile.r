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

  # Check that there are source files to compile
  srcfiles <- dir(srcdir, pattern = "\\.(c|cpp|f)$")
  if (length(srcfiles) == 0)
    return(invisible())

  # Compile the DLL
  srcfiles <- paste(srcfiles, collapse = " ")
  R(paste("CMD SHLIB", "-o", basename(dll_name(pkg)), srcfiles),
    path = srcdir)

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
