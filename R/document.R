#' Use roxygen to document a package.
#'
#' This function is a wrapper for the [roxygen2::roxygenize()]
#' function from the roxygen2 package. See the documentation and vignettes of
#' that package to learn how to use roxygen.
#'
#' @template devtools
#' @inheritParams roxygen2::roxygenise
#' @param quiet if `TRUE` suppresses output from this function.
#' @seealso [roxygen2::roxygenize()],
#'   `browseVignettes("roxygen2")`
#' @export
document <- function(pkg = ".", roclets = NULL, quiet = FALSE) {
  pkg <- as.package(pkg)
  if (!isTRUE(quiet)) {
    cli::cli_inform(c(i = "Updating {.pkg {pkg$package}} documentation"))
  }

  save_all()
  if (pkg$package == "roxygen2") {
    # roxygen2 crashes if it reloads itself
    load_all(pkg$path, quiet = quiet)
  }

  if (quiet) {
    output <- file_temp()
    withr::defer(file_delete(output))
    withr::local_output_sink(output)
  }
  withr::local_envvar(r_env_vars())

  roxygen2::roxygenise(pkg$path, roclets)
  pkgload::dev_topic_index_reset(pkg$package)
  invisible()
}
