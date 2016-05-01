#' Uninstall a local development package.
#'
#' Uses \code{remove.package} to uninstall the package.
#' To uninstall a package from a non-default library,
#' use \code{\link[withr]{with_libpaths}}.
#'
#' @inheritParams install
#' @param unload if \code{TRUE} (the default), will automatically unload the
#'   package prior to uninstalling.
#' @param ... additional arguments passed to \code{\link{remove.packages}}.
#' @export
#' @family package installation
#' @seealso \code{\link{with_debug}} to install packages with debugging flags
#'   set.
uninstall <- function(pkg = ".", unload = TRUE, quiet = FALSE, ...) {

  pkg <- as.package(pkg)

  if (unload && pkg$package %in% loaded_packages()$package) {
    unload(pkg)
  }

  if (!quiet) {
    message("Uninstalling ", pkg$package)
  }

  remove.packages(pkg$package)

  invisible(TRUE)
}
