#' @section Package options:
#'
#' Devtools uses the following [options()] to configure behaviour:
#' * `devtools.install.args`: a string giving extra arguments passed to
#'   `R CMD install` by [install()].
#' * `devtools.path`: Deprecated. Path used by the now-deprecated [dev_mode()]
#'   function.
#' @docType package
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom ellipsis check_dots_used
#' @importFrom lifecycle deprecated
## usethis namespace: end
NULL

# https://r-pkgs.org/dependencies-in-practice.html#how-to-not-use-a-package-in-imports
ignore_unused_imports <- function() {
  miniUI::miniPage
  profvis::profvis
  urlchecker::url_check
}
