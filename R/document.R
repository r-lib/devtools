#' Use roxygen to document a package.
#'
#' This function is a wrapper for the [roxygen2::roxygenize()]
#' function from the roxygen2 package. See the documentation and vignettes of
#' that package to learn how to use roxygen.
#'
#' @param pkg package description, can be path or package name.  See
#'   [as.package()] for more information
#' @inheritParams roxygen2::roxygenise
#' @seealso [roxygen2::roxygenize()],
#'   `browseVignettes("roxygen2")`
#' @export
document <- function(pkg = ".", roclets = NULL) {
  pkg <- as.package(pkg)
  message("Updating ", pkg$package, " documentation")

  save_all()

  if (pkg$package == "roxygen2") {
    # roxygen2 crashes if it reloads itself
    load_all(pkg$path, quiet = TRUE)
    load_code <- function(path) asNamespace("roxygen2")
  } else {
    load_code <- roxygen2::env_package
  }
  withr::with_envvar(r_env_vars(),
    roxygen2::roxygenise(pkg$path, roclets, load_code = load_code)
  )

  pkgload::dev_topic_index_reset(pkg$package)
  invisible()
}
