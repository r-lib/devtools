#' @inherit pkgload::load_all
#' @param ... Additional arguments passed to [pkgload::load].
#' @export
load_all <- function(path = ".", reset = TRUE, recompile = FALSE,
                     export_all = TRUE, helpers = TRUE, quiet = FALSE, ...) {
  save_all()

  pkgload::load_all(
    path = path, reset = reset, recompile = recompile,
    export_all = export_all, helpers = helpers, quiet = quiet, ...
  )
}

#' @importFrom pkgload unload
#' @export
pkgload::unload

#' @importFrom pkgload check_suggested
# This is just check_suggested from pkgload with a different default path
check_suggested <- function(package, version = NULL, compare = NA, path = pkgload::inst("devtools")) {
  pkgload::check_suggested(package = package, version = version, compare = compare, path = path)
}
