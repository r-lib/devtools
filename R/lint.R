#' Lint all source files in a package
#'
#' The default linters correspond to the style guide at
#' <https://style.tidyverse.org/>, however it is possible to override any or all
#' of them using the `linters` parameter.
#'
#' @template devtools
#' @param cache Store the lint results so repeated lints of the same content use
#'   the previous results. Consult the lintr package to learn more about its
#'   caching behaviour.
#' @param ... Additional arguments passed to [lintr::lint_package()].
#' @seealso [lintr::lint_package()], [lintr::lint()]
#' @export
lint <- function(pkg = ".", cache = TRUE, ...) {
  rlang::check_installed("lintr")
  pkg <- as.package(pkg)

  cli::cli_alert_info("Linting {.pkg {pkg$package}}")

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  lintr::lint_package(pkg$path, cache = cache, ...)
}
