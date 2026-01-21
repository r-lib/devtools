#' @template devtools
#' @param path Path in which to produce package.  If `NULL`, defaults to
#'   the parent directory of the package.
#' @inherit pkgbuild::build
#' @note The default `manual = FALSE` is not suitable for a CRAN
#'   submission, which may require `manual = TRUE`.  Even better, use
#'   [submit_cran()] or [release()].
#' @param ... Additional arguments passed to [pkgbuild::build].
#' @export
build <- function(
  pkg = ".",
  path = NULL,
  binary = FALSE,
  vignettes = TRUE,
  manual = FALSE,
  args = NULL,
  quiet = FALSE,
  ...
) {
  save_all()

  if (!file_exists(pkg)) {
    cli::cli_abort("{.arg pkg} must exist")
  }

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  pkgbuild::build(
    path = pkg,
    dest_path = path,
    binary = binary,
    vignettes = vignettes,
    manual = manual,
    args = args,
    quiet = quiet,
    ...
  )
}

#' @importFrom pkgbuild with_debug
#' @export
pkgbuild::with_debug

#' @importFrom pkgbuild clean_dll
#' @export
pkgbuild::clean_dll

#' @importFrom pkgbuild has_devel
#' @export
pkgbuild::has_devel

#' @importFrom pkgbuild find_rtools
#' @export
pkgbuild::find_rtools
