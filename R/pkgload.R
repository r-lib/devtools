#' @inherit pkgload::load_all
#' @param ... Additional arguments passed to [pkgload::load_all()].
#' @export
load_all <- function(
  path = ".",
  reset = TRUE,
  recompile = FALSE,
  export_all = TRUE,
  helpers = TRUE,
  quiet = FALSE,
  ...
) {
  if (inherits(path, "package")) {
    path <- path$path
  }

  if (is_loading()) {
    cli::cli_abort(c(
      "Recursive loading detected.",
      i = "Did you accidentally include {.fn load_all} in an R source file?"
    ))
  }

  save_all()

  check_dots_used(action = getOption("devtools.ellipsis_action", rlang::warn))

  pkgload::load_all(
    path = path,
    reset = reset,
    recompile = recompile,
    export_all = export_all,
    helpers = helpers,
    quiet = quiet,
    ...
  )
}

#' @importFrom pkgload is_loading
#' @export
pkgload::is_loading

#' @importFrom pkgload unload
#' @export
pkgload::unload
