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
#' @param path directory to library.
#' @param prompt logical. If TRUE, the command prompt shows the path directory to library
#' @export
#' @examples
#' \donttest{
#' dev_mode()
#' dev_mode()
#' }
dev_mode <- function(on = NULL, path = "~/R-dev", prompt = FALSE) {
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
    
    if (!is_library(path)) {
      warning(path, " does not appear to be a library. ", 
        "Are sure you specified the correct directory?", call. = FALSE)
    }

    message("Dev mode: ON")

    if (prompt) {
      .old_prompt <<- getOption("prompt")
      options(prompt = paste("DEVMODE[", basename(path), "] ", .old_prompt, sep = ""))
    }
    
    .libPaths(c(path, lib_paths))
  } else {
    if (!is.null(.old_prompt)) {
      options(prompt = .old_prompt)
      .old_prompt <<- NULL
    }
    message("Dev mode: OFF")
    
    # unlink(path, recursive = TRUE)
    .libPaths(setdiff(lib_paths, path))
  }  
}

is_library <- function(path) {
  # empty directories can be libraries
  if (length(dir(path)) == 0) return (TRUE)
  
  # otherwise check that the directories are compiled R directories -
  # i.e. that they contain a help directory
  dirs <- dir(path, full.names = TRUE)
  dirs <- dirs[file_test("-d", dirs)]
  
  has_pkg_dir <- function(path) length(dir(path, pattern = "Meta")) > 0
  help_dirs <- vapply(dirs, has_pkg_dir, logical(1))
  
  all(help_dirs)
}

.old_prompt <- NULL
