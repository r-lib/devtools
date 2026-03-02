#' @import fs
NULL

devtools_default_options <- list(
  devtools.path = "~/R-dev",
  devtools.install.args = "",
  devtools.ellipsis_action = warn
)

.onLoad <- function(libname, pkgname) {
  op <- options()
  toset <- !(names(devtools_default_options) %in% names(op))
  if (any(toset)) {
    options(devtools_default_options[toset])
  }

  invisible()
}
