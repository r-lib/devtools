#' Activate and deactivate development mode.
#'
#' When activated, \code{dev_mode} creates a new library for storing installed
#' packages. This new library is automatically created when \code{dev_mode} is 
#' activated if it does not already exist.
#' This allows you to test development packages in a sandbox, without
#' interfering with the other packages you have installed.
#'
#' @param on turn dev mode on (\code{TRUE}) or off (\code{FALSE}).  If omitted
#'  will guess based on whether or not \code{path} is in
#'  \code{\link{.libPaths}}
#' @param path directory to for library.
#' @export
#' @examples
#' \donttest{
#' dev_mode()
#' dev_mode()
#' }
dev_mode <- function(on = NULL, path = "~/R-dev") {
  lib_paths <- .libPaths()

  path <- normalizePath(path, winslash = "/", mustWork = FALSE)
  if (is.null(on)) {
    on <- !(path %in% lib_paths)
  }

  if (on) {
    if (!file.exists(path)) {
      dir.create(path, recursive = TRUE, showWarnings = FALSE)
    }
    if (!file.exists(path)) {
      stop("Failed to create ", path, call. = FALSE)
    }

    message("Dev mode: ON")
    .libPaths(c(path, lib_paths))
  } else {
    message("Dev mode: OFF")
    # unlink(path, recursive = TRUE)
    .libPaths(setdiff(lib_paths, path))
  }  
}