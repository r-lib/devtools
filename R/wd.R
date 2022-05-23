#' Set working directory.
#'
#' @template devtools
#' @param path path within package. Leave empty to change working directory
#'   to package directory.
#' @export
wd <- function(pkg = ".", path = "") {
  pkg <- as.package(pkg)
  path <- path(pkg$path, path)

  if (!file_exists(path)) {
    cli::cli_abort("{.path {path} does not exist")
  }

  cli::cli_inform(c(i = "Changing working directory to {.path {path}}"))
  setwd(path)
}
