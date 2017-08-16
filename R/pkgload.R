#' @inherit pkgload::load_all
#' @param ... Additional arguments passed to [pkgload::load].
#' @export
load_all <- function(path = ".", reset = TRUE, recompile = FALSE,
                     export_all = TRUE, helpers = TRUE, recollate = FALSE,
                     quiet = FALSE, ...) {
  if (rstudioapi::isAvailable()) {
    rstudioapi::documentSaveAll()
  }

  pkgload::load_all(path = path, reset = reset, recompile = recompile,
    export_all = export_all, helpers = helpers, recollate = recollate,
    quiet = quiet, ...)
}

#' @importFrom pkgload unload
#' @export
pkgload::unload

#' @importFrom pkgload check_suggested
pkgload::check_suggested
