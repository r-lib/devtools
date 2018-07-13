
#' Execute \pkg{pkgdown} build_site in a package
#'
#' `build_site()` is a shortcut for [pkgdown::build_site()], it generates the
#'   static HTML documentation.
#'
#' @param path path to the package to build the static HTML.
#' @param ...  additional arguments passed to [pkgdown::build_site()]
#'
#' @inheritParams pkgdown::build_site
#'
#' @return NULL
#' @export

build_site <- function(path = ".", ...) {
  check_suggested("pkgdown", path = path)

  if (rstudioapi::hasFun("documentSaveAll")) {
    rstudioapi::documentSaveAll()
  }

  pkg <- as.package(path)

  withr::with_temp_libpaths(action = "prefix", code = {
    install(pkg = pkg$path, reload = FALSE)
    pkgdown::build_site(pkg = pkg$path, ...)
  })
}
