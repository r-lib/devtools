#' Unload and reload package.
#'
#' This attempts to unload and reload a package. If the package is not loaded
#' already, it does nothing. It's not always possible to cleanly unload a
#' package: see the caveats in \code{\link{unload}} for the some of the
#' potential failure points. If in doubt, restart R and reload the package
#' with \code{\link{library}}.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param quiet if \code{TRUE} suppresses output from this function.
#' @examples
#' \dontrun{
#' # Reload package that is in current directory
#' reload(".")
#'
#' # Reload package that is in ./ggplot2/
#' reload("ggplot2/")
#'
#' # Can use inst() to find the package path
#' # This will reload the installed ggplot2 package
#' reload(inst("ggplot2"))
#' }
#' @export
reload <- function(pkg = ".", quiet = FALSE) {
  pkg <- as.package(pkg)

  if (is_attached(pkg)) {
    if (!quiet) message("Reloading installed ", pkg$package)
    unload(pkg)
    require(pkg$package, character.only = TRUE, quietly = TRUE)
  }
}

