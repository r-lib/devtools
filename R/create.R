#' Create a package
#'
#' @param path A path. If it exists, it is used. If it does not exist, it is
#'   created, provided that the parent path exists.
#' @param ... Additional arguments passed to [usethis::create_package()]
#' @return The path to the created package, invisibly.
#' @export
create <- function(path, ...) {
  usethis::create_package(path, ...)
}
