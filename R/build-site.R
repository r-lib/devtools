#' Run `pkgdown::build_site()`
#'
#' This is a thin wrapper around [pkgdown::build_site()], used for generating
#' static HTML documentation. Learn more at <https://pkgdown.r-lib.org>.
#'
#' @param path Path to the package to build the static HTML.
#' @param ...  Additional arguments passed to [pkgdown::build_site()].
#' @export
build_site <- function(path = ".", ...) {
  rlang::check_installed("pkgdown")

  save_all()
  pkgdown::build_site(pkg = path, ...)
}
