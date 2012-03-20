#' @title System Path Manipulations
#' @rdname path
#' @details
#' \code{get_path()} will retrieve the system path, also known as the $PATH, or 
#' %PATH% environment variable.  The system path the the set of directories 
#' that the system will search to find programs and executables.
#' 
#' \code{get_path} will retrieve the system path as a caracter vector of directories.
#' 
#' @export
#' @examples
#' (path <- get_path())
#' length(path)
get_path <- function() {
  strsplit(Sys.getenv("PATH"),.Platform$path.sep)[[1]]
}

#' @rdname path
#' @param path character vector of locations
#' @details
#' \code{set_path()}  Takes a character vector of directories, 
#' and sets the path to that list.
#' The changes remain in effect until the end of the session.
#' @export
set_path <- function(path) {
  sep  <- .Platform$path.sep
  path <- paste(normalizePath(path), sep = sep, collapse = sep)
  Sys.setenv(PATH = path)
}


#' @rdname path
#' @param ... character locations
#' @param after the place on the path, defaults to first
#' @details
#' add_path temporarily adds location(s) to the system path.
#' Added paths will be available to R and to any sub processes 
#' until the end of the R session, or unless otherwise overwritten.
#' 
#' @export
#' @examples
#' add_path(R.home())
#' get_path()
add_path <- function(..., after = 0) {
  newpaths <- normalizePath(as.character(c(...)), mustWork = TRUE)
  set_path(append(get_path(), newpaths, after))
}


#' Test if an object is on the path
#' @param ... character vectors indicating the exacutables to check for on the path.
#' @return logical TRUE of FALSE for each element of \code{...} indicating
#'   if it was found on the system path.
#' @export
on_path <- function(...) {
 unname(Sys.which(as.character(c(...))) != "")
}
