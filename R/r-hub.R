#' Run CRAN checks for package on R-hub
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function is deprecated since the underlying function
#' `rhub::check_for_cran()` is now deprecated and defunct. See [`rhub::rhubv2`]
#' learn about the new check system, R-hub v2.
#'
#' @param platforms R-hub platforms to run the check on.
#' @param email email address to notify.
#' @param interactive whether to show the status of the build.
#' @param build_args Arguments passed to `R CMD build`.
#' @param ... extra arguments, passed to `rhub::check_for_cran()`.
#' @inheritParams check
#' @return a `rhub_check` object.
#' @keywords internal
#' @export
check_rhub <- function(
  pkg = ".",
  platforms = NULL,
  email = NULL,
  interactive = TRUE,
  build_args = NULL,
  ...
) {
  lifecycle::deprecate_stop("2.4.6", "check_rhub()")
}
