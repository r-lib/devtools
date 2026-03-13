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

  # On certain linux systems, pak might call `sudo`, as a probe for
  # capabilities. That lays the ground work for a potential need to work with
  # sysreqs, but that's not necessary in this case and CRAN flags the
  # `sudo -s id` as problematic. Setting `pkg.sysreq` to `FALSE` prevents
  # pak from even checking this.
  # https://pak.r-lib.org/reference/pak-config.html#pak-configuration
  if (Sys.getenv("_R_CHECK_PACKAGE_NAME_", "") != "") {
    options(pkg.sysreqs = FALSE)
  }

  invisible()
}
