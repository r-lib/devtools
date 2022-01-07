#' Uninstall a local development package
#'
#' Uses `remove.packages()` to uninstall the package. To uninstall a package
#' from a non-default library, use in combination with [withr::with_libpaths()].
#'
#' @inheritParams install
#' @param unload if `TRUE` (the default), ensures the package is unloaded, prior
#'   to uninstalling.
#' @inheritParams utils::remove.packages
#' @export
#' @family package installation
#' @seealso [with_debug()] to install packages with debugging flags set.
uninstall <- function(pkg = ".", unload = TRUE, quiet = FALSE, lib = .libPaths()[[1]]) {
  pkg <- as.package(pkg)

  if (unload && pkg$package %in% loaded_packages()$package) {
    pkgload::unload(pkg$package)
  }

  if (!quiet) {
    cli::cli_alert_info("Uninstalling {.pkg {pkg$package}}")
  }

  remove.packages(pkg$package, .libPaths()[[1]])

  invisible(TRUE)
}
