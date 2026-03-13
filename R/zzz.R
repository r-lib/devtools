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

  # Prevent pak from trying to install system requirements during R CMD check.
  # On certain linux systems, it might call `sudo`, as a probe for capabilities.
  # That is flagged by CRAN as problematic.
  if (Sys.getenv("_R_CHECK_PACKAGE_NAME_", "") != "") {
    options(pkg.sysreqs = FALSE)
  }

  invisible()
}
