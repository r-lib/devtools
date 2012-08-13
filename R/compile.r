#' Compile a .dll/.so from source
#'
#' The DLL is stored in the same directory as the source code,
#' \code{/src/}.
#'
#' Invisibly returns the names of the DLL.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @seealso \code{\link{clean_dll}}
#' @export
compile_dll <- function(pkg) {
  pkg <- as.package(pkg)

  # Check source dir exists
  srcdir <- file.path(pkg$path, "src")
  if (!dir.exists(srcdir))
    return(invisible())

  # Check that there are source files to compile
  srcfiles <- dir(srcdir, pattern = "\\.c$")
  if (length(srcfiles) == 0)
    return(invisible())

  # Compile the DLL
  R(paste("CMD SHLIB *.c -o", basename(dll_name(pkg))),
    path = srcdir)

  invisible(dll_name(pkg))
}

#' Remove compiled objects from pkgdir/src
#'
#' Invisibly returns the names of the deleted files.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @seealso \code{\link{compile_dll}}
#' @export
clean_dll <- function(pkg) {
  pkg <- as.package(pkg)

  # Clean out the /src/ directory
  files <- dir(file.path(pkg$path, "src"),
    pattern = "\\.(o|sl|so|dylib|a|dll|def)$",
    full.names = TRUE)
  unlink(files)

  invisible(files)
}

# Returns the full path and name of the DLL file
dll_name <- function(pkg) {
  pkg <- as.package(pkg)

  name <- paste(pkg$package, .Platform$dynlib.ext, sep = "")

  file.path(pkg$path, "src", name)
}
