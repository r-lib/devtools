#' Unload and reload package
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' `reload()` is deprecated because we no longer use or recommend this
#' workflow. Instead, we recommend [load_all()] to load a package for
#' interactive development.
#'
#' @template devtools
#' @param quiet if `TRUE` suppresses output from this function.
#' @seealso [load_all()] to load a package for interactive development.
#' @export
#' @keywords internal
reload <- function(pkg = ".", quiet = FALSE) {
  lifecycle::deprecate_warn("2.5.0", "reload()", "load_all()")
  pkg <- as.package(pkg)

  if (is_attached(pkg)) {
    if (!quiet) {
      cli::cli_inform(c(i = "Reloading attached {.pkg {pkg$package}}"))
    }
    pkgload::unload(pkg$package)
    require(pkg$package, character.only = TRUE, quietly = TRUE)
  } else if (is_loaded(pkg)) {
    if (!quiet) {
      cli::cli_inform(c(i = "Reloading loaded {.pkg {pkg$package}}"))
    }
    pkgload::unload(pkg$package)
    requireNamespace(pkg$package, quietly = TRUE)
  }
}
