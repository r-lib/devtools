#' Activate and deactivate development mode.
#'
#' When activated, `dev_mode` creates a new library for storing installed
#' packages. This new library is automatically created when `dev_mode` is
#' activated if it does not already exist.
#' This allows you to test development packages in a sandbox, without
#' interfering with the other packages you have installed.
#'
#' @param on turn dev mode on (`TRUE`) or off (`FALSE`).  If omitted
#'  will guess based on whether or not `path` is in
#'  [.libPaths()]
#' @param path directory to library.
#' @export
#' @examples
#' \dontrun{
#' dev_mode()
#' dev_mode()
#' }
dev_mode <- local({
  .prompt <- NULL

  function(on = NULL, path = getOption("devtools.path")) {
    lib_paths <- .libPaths()

    path <- path_real(path)
    if (is.null(on)) {
      on <- !(path %in% lib_paths)
    }

    if (on) {
      if (!file_exists(path)) {
        dir_create(path)
      }
      if (!file_exists(path)) {
        cli::cli_abort("Failed to create {.path {path}}")
      }

      if (!is_library(path)) {
        cli::cli_warn(c(
          "{.path {path}} does not appear to be a library.",
          "Are sure you specified the correct directory?"
        ))
      }

      cli::cli_inform(c(v = "Dev mode: ON"))
      options(dev_path = path)

      if (is.null(.prompt)) .prompt <<- getOption("prompt")
      options(prompt = paste("d> "))

      .libPaths(c(path, lib_paths))
    } else {
      cli::cli_inform(c(v = "Dev mode: OFF"))
      options(dev_path = NULL)

      if (!is.null(.prompt)) options(prompt = .prompt)
      .prompt <<- NULL

      .libPaths(setdiff(lib_paths, path))
    }
  }
})

is_library <- function(path) {
  # empty directories can be libraries
  if (length(dir_ls(path)) == 0) return(TRUE)

  # otherwise check that the directories are compiled R directories -
  # i.e. that they contain a Meta directory
  dirs <- dir_ls(path, type = "directory")

  has_pkg_dir <- function(path) length(dir_ls(path, regexp = "Meta")) > 0
  help_dirs <- vapply(dirs, has_pkg_dir, logical(1))

  all(help_dirs)
}
