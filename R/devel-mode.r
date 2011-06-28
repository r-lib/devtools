#' Activate and deactivate development mode.
#'
#' When activated, \code{dev_mode} creates a new library for storing installed
#' packages. This is automatically removed when \code{dev_mode} is activated.
#' This allows you to test development packages in a sandbox, without
#' interfering with the other packages you have installed.
#'
#' @param on turn dev mode on (\code{TRUE}) or off (\code{FALSE}).  If omitted
#'  will guess based on whether or not \code{path} is in
#'  \code{\link{.libPaths}}
#' @param path directory to for library.
#' @export
#' @examples
#' dev_mode()
#' dev_mode()
dev_mode <- function(on = NULL, path = "~/R-dev") {
  lib_paths <- .libPaths()

  path <- normalizePath(path, mustWork = FALSE)
  if (is.null(on)) {
    on <- !(path %in% lib_paths)
  }

  if (on) {
    message("Dev mode: ON")
    dir.create(path, showWarnings = FALSE)
    .libPaths(c(path, lib_paths))
  } else {
    message("Dev mode: OFF")
    # unlink(path, recursive = TRUE)
    .libPaths(setdiff(lib_paths, path))
  }  
}