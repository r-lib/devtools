#' Build package in specified directory.
#' 
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param path path in which to produce package.  If \code{NULL}, defaults to
#'   the parent directory of the package.
#' @param binary Produce a binary (\code{--binary}) or source (
#'   \code{--no-manual --no-vignettes}) version of the package.
#' @export
#' @return a string giving the location (including file name) of the built
#'  package
build <- function(pkg = NULL, path = NULL, binary = FALSE) {
  pkg <- as.package(pkg)
  if (is.null(path)) {
    path <- dirname(pkg$path)
  }
  
  if (binary) {
    cmd <- paste("CMD install ", shQuote(pkg$path), " --build", sep = "")
    ext <- if (os() == "win") "zip" else "tgz"
  } else {
    cmd <- paste("CMD build ", shQuote(pkg$path), 
      " --no-manual --no-vignettes", sep = "")
    ext <- "tar.gz"
  }
  R(cmd, path)

  targz <- paste(pkg$package, "_", pkg$version, ".", ext, sep = "")
  file.path(path, targz)
}