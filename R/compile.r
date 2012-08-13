#' Compile a .dll/.so from source
#'
#' The DLL is stored in the same directory as the source code,
#' \code{/src/}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @seealso \code{\link{clean_dll}}
#' @export
compile_dll <- function(pkg) {
  pkg <- as.package(pkg)

  # Check source dir exists
  srcdir <- dll_srcdir(pkg)
  if (!file.exists(srcdir) || !file.info(srcdir)$isdir)
    return(invisible())

  # Check that there are source files to compile
  srcfiles <- dir(dll_srcdir(pkg), pattern = "\\.c$")
  if (length(srcfiles) == 0)
    return(invisible())

  # Compile the DLL
  R(paste("CMD SHLIB *.c -o", basename(dll_name(pkg))),
    path = dll_srcdir(pkg))

  invisible()
}

#' Remove compiled objects from pkgdir/src
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @seealso \code{\link{compile_dll}}
#' @export
clean_dll <- function(pkg) {
  pkg <- as.package(pkg)

  # Clean out the /src/ directory
  files <- dir(dll_srcdir(pkg), pattern = "\\.(dll|so|o)$",
    full.names = TRUE)
  unlink(files)
}

# Returns the full path and name of the DLL file
dll_name <- function(pkg) {
  pkg <- as.package(pkg)

  name <- paste(pkg$package, .Platform$dynlib.ext, sep = "")

  file.path(dll_srcdir(pkg), name)
}

# Return the directory containing code that will be compiled
dll_srcdir <- function(pkg) {
  pkg <- as.package(pkg)
  file.path(pkg$path, "src")
}
