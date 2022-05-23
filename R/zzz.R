#' @importFrom utils available.packages contrib.url install.packages
#'   installed.packages modifyList packageDescription
#'   packageVersion remove.packages
#' @importFrom cli cat_rule cat_bullet
#' @import fs
NULL

#' Deprecated Functions
#'
#' These functions are Deprecated in this release of devtools, they will be
#' marked as Defunct and removed in a future version.
#' @name devtools-deprecated
#' @keywords internal
NULL

devtools_default_options <- list(
  devtools.path = "~/R-dev",
  devtools.install.args = "",
  devtools.ellipsis_action = rlang::warn
)

.onLoad <- function(libname, pkgname) {
  op <- options()
  toset <- !(names(devtools_default_options) %in% names(op))
  if (any(toset)) options(devtools_default_options[toset])

  invisible()
}
