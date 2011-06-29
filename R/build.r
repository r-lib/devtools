#' Build package in specified directory.
#' 
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param path path in which to produce package
#' @return a string giving the location (including file name) of the built
#'  package
build <- function(pkg = NULL, path = tempdir()) {
  pkg <- as.package(pkg)
  
  R(paste("CMD build ", shQuote(pkg$path), sep = ""), path)

  targz <- paste(pkg$package, "_", pkg$version, ".tar.gz", sep = "")
  file.path(path, targz)
}