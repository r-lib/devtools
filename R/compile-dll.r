#' Compile a .dll/.so from source.
#'
#' \code{compile_dll} performs a fake R CMD install so should code that
#' works here should work with a regular install (and vice versa).
#'
#' During compilation, debug flags are set with
#' \code{\link{compiler_flags}(TRUE)}.
#'
#' Invisibly returns the names of the DLL.
#'
#' @note If this is used to compile code that uses Rcpp, you will need to
#'   add the following line to your \code{Makevars} file so that it
#'   knows where to find the Rcpp headers:
#'   \code{PKG_CPPFLAGS=`$(R_HOME)/bin/Rscript -e 'Rcpp:::CxxFlags()'`}
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param quiet if \code{TRUE} suppresses output from this function.
#' @seealso \code{\link{clean_dll}} to delete the compiled files.
#' @export
compile_dll <- function(pkg = ".", quiet = FALSE) {
  pkg <- as.package(pkg)

  old <- set_envvar(compiler_flags(TRUE), "prefix")
  on.exit(set_envvar(old))

  if (!needs_compile(pkg)) return(invisible())
  compile_rcpp_attributes(pkg)

  # Mock install the package to generate the DLL
  if (!quiet) message("Re-compiling ", pkg$package)
  inst <- install_min(pkg, tempdir(), components = "libs",
    args = if (needs_clean(pkg)) "--preclean",
    quiet = quiet)

  invisible(dll_path(pkg))
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
dll_path <- function(pkg = ".") {
  pkg <- as.package(pkg)

  name <- paste(pkg$package, .Platform$dynlib.ext, sep = "")
  file.path(pkg$path, "src", name)
}

mtime <- function(x) {
  x <- x[file.exists(x)]
  if (length(x) == 0) return(NULL)
  max(file.info(x)$mtime)
}

# List all source files in the package
sources <- function(pkg = ".") {
  pkg <- as.package(pkg)

  srcdir <- file.path(pkg$path, "src")
  dir(srcdir, "\\.(c.*|f)$", recursive = TRUE, full.names = TRUE)
}

# List all header files in the package
headers <- function(pkg = ".") {
  pkg <- as.package(pkg)

  incldir <- file.path(pkg$path, "inst", "include")
  srcdir <- file.path(pkg$path, "src")

  c(
    dir(srcdir, "^Makevars.*$", recursive = TRUE, full.names = TRUE),
    dir(srcdir, "\\.h.*$", recursive = TRUE, full.names = TRUE),
    dir(incldir, "\\.h.*$", recursive = TRUE, full.names = TRUE)
  )
}

# Does the package need recompiling?
# (i.e. is there a source or header file newer than the dll)
needs_compile <- function(pkg = ".") {
  pkg <- as.package(pkg)

  source <- mtime(c(sources(pkg), headers(pkg)))
  # no source files, so doesn't need compile
  if (is.null(source)) return(FALSE)

  dll <- mtime(dll_path(pkg))
  # no dll, so needs compile
  if (is.null(dll)) return(TRUE)

  source > dll
}

# Does the package need a clean compile?
# (i.e. is there a header or Makevars newer than the dll)
needs_clean <- function(pkg = ".") {
  pkg <- as.package(pkg)

  headers <- mtime(headers(pkg))
  # no headers, so never needs clean compile
  if (is.null(headers)) return(FALSE)

  dll <- mtime(dll_path(pkg))
  # no dll, so needs compile
  if (is.null(dll)) return(TRUE)

  headers > dll
}
