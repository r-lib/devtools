#' get the PATH variable as a vector 
#' @export
#' @examples
#' path <- get_path()
#' length(path)
get_path <- function() {
  strsplit(Sys.getenv("PATH"),.Platform$path.sep)[[1]]
}

#' set the path from a vector of individual paths
#' @param path character vector of locations
#' @note This only works for the current session.  The path is not set permanantly.
#' @export
set_path <- function(path) {
  sep  <- .Platform$path.sep
  path <- paste(normalizePath(path), sep = sep, collapse = sep)
  Sys.setenv(PATH = path)
}

#' Add a location to the Path variable
#' 
#' Temporarily adds a location to the path.
#' 
#' @param ... character locations
#' @param after the place on the path, defaults to the end
#' @export
#'
add_path <- function(..., after = Inf) {
  newpaths <- normalizePath(as.character(c(...)), mustWork = TRUE)
  set_path(append(get_path(), newpaths, after))
}


#' test if an object is on the path
#' @param ... Strings indicating the exacutables to check for on the path.
#' @export
on_path <- function(...) {
 unname(Sys.which(as.character(c(...))) != "")
}
