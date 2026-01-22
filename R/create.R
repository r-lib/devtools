#' Create a package
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' `create()` is deprecated. Please use [usethis::create_package()] directly
#' instead.
#'
#' @param path A path. If it exists, it is used. If it does not exist, it is
#'   created, provided that the parent path exists.
#' @param ... Additional arguments passed to [usethis::create_package()]
#' @inheritParams usethis::create_package
#' @return The path to the created package, invisibly.
#' @export
#' @keywords internal
create <- function(path, ..., open = FALSE) {
  lifecycle::deprecate_warn("2.5.0", "create()", "usethis::create_package()")
  usethis::create_package(path, ..., open = open)
}
