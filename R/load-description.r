#' Reads the DESCRIPTION file for the given package.
#' @param path to the package
#' @return description of the package
#' @export
load_description <- function(path)
  read.dcf(file.path(path, 'DESCRIPTION'))
