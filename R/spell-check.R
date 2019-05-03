#' Spell checking
#'
#' Runs a spell check on text fields in the package description file, manual
#' pages, and optionally vignettes. Wraps the \link[spelling:spell_check_package]{spelling}
#' package.
#'
#' @export
#' @rdname spell_check
#' @param pkg package description, can be path or package name.  See
#'   [as.package()] for more information
#' @param vignettes also check all `rmd` and `rnw` files in the pkg `vignettes` folder
#' @param use_wordlist ignore words in the package [WORDLIST][spelling::get_wordlist] file
#' @inheritParams spelling::spell_check_package
spell_check <- function(pkg = ".", vignettes = TRUE, use_wordlist = TRUE) {
  pkg <- as.package(pkg)
  spelling::spell_check_package(pkg = pkg, vignettes = vignettes, use_wordlist = use_wordlist)
}
