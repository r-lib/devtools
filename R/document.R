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
    message("Updating ", pkg$package, " documentation")
  }

  save_all()

  if (pkg$package == "roxygen2") {
    # roxygen2 crashes if it reloads itself
    load_all(pkg$path, quiet = quiet)
    load_code <- function(path) asNamespace("roxygen2")
  } else {
    load_code <- function(path) {
      pkgload::load_all(path, compile = FALSE, helpers = FALSE, attach_testthat = FALSE, quiet = quiet)$env
    }
  }

  if (quiet) {
    output <- tempfile()
    on.exit(unlink(output))

    withr::local_output_sink(output)
  }

  withr::with_envvar(r_env_vars(),
    roxygen2::roxygenise(pkg$path, roclets, load_code = load_code)
  )

  pkgload::dev_topic_index_reset(pkg$package)
  invisible()
}
