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
    path <- basename(pkg$path)
  }
  
  if (binary) {
    options <- "--binary"
  } else {
    options <- "--no-manual --no-vignettes"
  }
  
  R(paste("CMD build ", shQuote(pkg$path), " ", options, sep = ""), path)

  targz <- paste(pkg$package, "_", pkg$version, ".tar.gz", sep = "")
  file.path(path, targz)
}