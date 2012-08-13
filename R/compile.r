#' Compile a .dll/.so from source
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
compile_dll <- function(pkg) {
  pkg <- as.package(pkg)

  # Check source dir exists
  srcdir <- dll_srcdir(pkg)
  if (!file.exists(srcdir) || !file.info(srcdir)$isdir)
    return(invisible())

  # Check that there are source files to compile
  srcfiles <- list.files(dll_srcdir(pkg), pattern = ".c$")
  if (length(srcfiles) == 0)
    return(invisible())

  # Compile the DLL
  R(paste("CMD SHLIB *.c -o", dll_name(pkg)), path = dll_srcdir(pkg))

  invisible()
}

#' Remove compiled objects from pkgdir/src
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
clean_dll <- function(pkg) {
  pkg <- as.package(pkg)

  # Clean out the /src/ directory
  files <- list.files(dll_srcdir(pkg), pattern = "\\.(dll|so|o)$",
    full.names = TRUE)
  unlink(files)
}

# Returns the name of the DLL file, with or without extension,
# and with or without path
dll_name <- function(pkg, ext = TRUE, path = FALSE) {
  pkg <- as.package(pkg)

  if (ext) {
    name <- paste(pkg$package, .Platform$dynlib.ext, sep = "")
  } else {
    name <- pkg$package
  }

  if (path) {
    file.path(dll_srcdir(pkg), name)
  } else {
    name
  }
}

# Return the directory containing code that will be compiled
dll_srcdir <- function(pkg) {
  pkg <- as.package(pkg)
  file.path(pkg$path, "src")
}
