#' Get/set the PATH variable.
#' 
#' @param path character vector of paths
#' @return \code{set_path} invisibly returns the old path.
#' @name path
#' @family path
#' @seealso \code{\link{with_path}} to temporarily set the path for a block
#'   of code
#' @examples
#' path <- get_path()
#' length(path)
#' old <- add_path(".")
#' length(get_path())
#' set_path(old)
#' length(get_path())
NULL

#' @export
#' @rdname path
get_path <- function() {
  strsplit(Sys.getenv("PATH"), .Platform$path.sep)[[1]]
}

#' @export
#' @rdname path
set_path <- function(path) {
  path <- normalizePath(path, mustWork = FALSE)
  
  old <- get_path()
  path <- paste(path, collapse = .Platform$path.sep)
  Sys.setenv(PATH = path)
  invisible(old)
}

#' @export
#' @rdname path
#' @param after for \code{add_path}, the place on the PATH where the new paths
#'   should be added
add_path <- function(path, after = Inf) {
  set_path(append(get_path(), path, after))
}


#' Test if an object is on the path.
#'
#' @param ... Strings indicating the executables to check for on the path.
#' @family path
#' @keywords internal
#' @export
#' @examples
#' on_path("R")
#' on_path("gcc")
#' on_path("foo", "bar")  # FALSE in most cases
#' with_path(tempdir(), on_path("gcc"))
on_path <- function(...) {
  commands <- c(...)
  stopifnot(is.character(commands))
  unname(Sys.which(commands) != "")
}