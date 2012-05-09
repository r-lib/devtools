#' Get the PATH variable as a vector.
#' 
#' @export
#' @family path
#' @examples
#' path <- get_path()
#' length(path)
get_path <- function() {
  strsplit(Sys.getenv("PATH"),.Platform$path.sep)[[1]]
}

#' Set the path from a vector of individual paths.
#'
#' @param path character vector of locations
#' @note This only works for the current session.  The path is not set permanently.
#' @return invisibly returns the old path.
#' @family path
#' @export
set_path <- function(path) {
  old.path <- get_path()
  sep  <- .Platform$path.sep
  path <- paste(normalizePath(path), sep = sep, collapse = sep)
  Sys.setenv(PATH = path)
  return(invisible(old.path))
}

#' Add a location to the Path variable.
#' 
#' Temporarily adds a location to the path.
#' 
#' @param ... character locations
#' @param after the place on the path, defaults to the end
#' @family path
#' @return invisibly returns the old path.
#' @export
#'
add_path <- function(..., after = Inf) {
  newpaths <- normalizePath(as.character(c(...)), mustWork = TRUE)
  set_path(append(get_path(), newpaths, after))
}


#' Test if an object is on the path.
#'
#' @param ... Strings indicating the executables to check for on the path.
#' @family path
#' @export
#' @examples
#' on_path("R")
#' on_path("gcc")
#' on_path("foo", "bar")  # FALSE in most cases
on_path <- function(...) {
 unname(Sys.which(as.character(c(...))) != "")
}
