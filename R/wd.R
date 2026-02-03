#' Set working directory
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' `wd()` is deprecated because we no longer use or recommend this workflow.
#' Set working directory
#'
#' @template devtools
#' @param path path within package. Leave empty to change working directory
#'   to package directory.
#' @export
#' @keywords internal
wd <- function(pkg = ".", path = "") {
  lifecycle::deprecate_warn("2.5.0", "wd()")
  pkg <- as.package(pkg)
  path <- path(pkg$path, path)

  if (!file_exists(path)) {
    cli::cli_abort("{.path {path} does not exist")
  }

  cli::cli_inform(c(i = "Changing working directory to {.path {path}}"))
  setwd(path)
}
