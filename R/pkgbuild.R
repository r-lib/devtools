#' @inherit pkgbuild::build
#' @param ... Additional arguments passed to [pkgbuild::build].
#' @export
build <- function(path = ".", dest_path = NULL, binary = FALSE, vignettes = TRUE,
                  manual = FALSE, args = NULL, quiet = FALSE, ...) {
  save_all()
  pkgbuild::build(
    path = path, dest_path = dest_path, binary = binary,
    vignettes = vignettes, manual = manual, args = args, quiet = quiet, ...
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
