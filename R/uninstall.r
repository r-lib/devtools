#' Uninstall a local development package.
#'
#' Uses `remove.package` to uninstall the package.
#' To uninstall a package from a non-default library,
#' use [withr::with_libpaths()].
#'
#' @inheritParams install
#' @param unload if `TRUE` (the default), will automatically unload the
#'   package prior to uninstalling.
#' @param ... additional arguments passed to [remove.packages()].
#' @export
#' @family package installation
#' @seealso [with_debug()] to install packages with debugging flags
#'   set.
uninstall <- function(pkg = ".", unload = TRUE, quiet = FALSE, ...) {
  pkg <- as.package(pkg)

  if (unload && pkg$package %in% loaded_packages()$package) {
    pkgload::unload(pkg$package)
  }

  if (!quiet) {
    message("Uninstalling ", pkg$package)
  }

  remove.packages(pkg$package)

  invisible(TRUE)
}
