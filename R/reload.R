#' Unload and reload package.
#'
#' This attempts to unload and reload an _installed_ package. If the package is
#' not loaded already, it does nothing. It's not always possible to cleanly
#' unload a package: see the caveats in [unload()] for some of the potential
#' failure points. If in doubt, restart R and reload the package with
#' [library()].
#'
#' @template devtools
#' @param quiet if `TRUE` suppresses output from this function.
#' @seealso [load_all()] to load a package for interactive development.
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
#' reload(pkgload::inst("ggplot2"))
#' }
#' @export
reload <- function(pkg = ".", quiet = FALSE) {
  pkg <- as.package(pkg)

  if (is_attached(pkg)) {
    if (!quiet) cli::cli_inform(c(i = "Reloading attached {.pkg {pkg$package}}"))
    pkgload::unload(pkg$package)
    require(pkg$package, character.only = TRUE, quietly = TRUE)
  } else if (is_loaded(pkg)) {
    if (!quiet) cli::cli_inform(c(i = "Reloading loaded {.pkg {pkg$package}}"))
    pkgload::unload(pkg$package)
    requireNamespace(pkg$package, quietly = TRUE)
  }
}
