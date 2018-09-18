#' Lint all source files in a package.
#'
#' The default lintings correspond to the style guide at
#' <http://r-pkgs.had.co.nz/r.html#style>, however it is possible to
#' override any or all of them using the `linters` parameter.
#' @param pkg package description, can be path or package name. See
#'   [as.package()] for more information
#' @param cache store the lint results so repeated lints of the same content
#' use the previous results.
#' @param ... additional arguments passed to [lintr::lint_package()]
#' @seealso [lintr::lint_package()], [lintr::lint()]
#' @details
#' The lintr cache is by default stored in `~/.R/lintr_cache/` (this can
#' be configured by setting `options(lintr.cache_directory)`).  It can be
#' cleared by calling [lintr::clear_cache()].
#' @export
lint <- function(pkg = ".", cache = TRUE, ...) {
  check_suggested("lintr")
  pkg <- as.package(pkg)

  message("Linting ", pkg$package, appendLF = FALSE)
  lintr::lint_package(pkg$path, cache = cache, ...)
}
