#' Spell checking
#'
#' Runs a spell check on text fields in the package description file, manual
#' pages, and optionally vignettes. Wraps the \link[spelling:spell_check_package]{spelling}
#' package.
#' manual pages. Hunspell includes dictionaries for \code{en_US} and \code{en_GB}
#' by default. Other languages require installation of a custom dictionary, see
#' the \href{https://cran.r-project.org/package=hunspell/vignettes/intro.html#system_dictionaries}{hunspell vignette}
#' for details.
#'
#' @export
#' @rdname spell_check
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param vignettes include vignettes in the spell check; passed to
#' \link[spelling:spell_check_package]{spelling::spell_check_package}
spell_check <- function(pkg = ".", vignettes = TRUE) {
  pkg <- as.package(pkg)
  spelling::spell_check_package(pkg = pkg, vignettes = vignettes)
}
