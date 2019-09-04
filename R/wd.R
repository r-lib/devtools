#' Set working directory.
#'
#' @template devtools
#' @param path path within package. Leave empty to change working directory
#'   to package directory.
#' @export
wd <- function(pkg = ".", path = "") {
  pkg <- as.package(pkg)
  path <- file.path(pkg$path, path)

  if (!file.exists(path)) {
    stop(path, " does not exist", call. = FALSE)
  }

  message("Changing working directory to ", path)
  setwd(path)
}
