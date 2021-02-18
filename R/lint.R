#' Lint all source files in a package.
#'
#' The default linters correspond to the style guide at
#' <https://style.tidyverse.org/>, however it is possible to
#' override any or all of them using the `linters` parameter.
#' @template devtools
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
  rlang::check_installed("lintr")
  pkg <- as.package(pkg)

  cli::cli_alert_info("Linting {.pkg {pkg$package}}")

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  lintr::lint_package(pkg$path, cache = cache, ...)
}
