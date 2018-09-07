#' Use roxygen to document a package.
#'
#' This function is a wrapper for the \code{\link[roxygen2]{roxygenize}()}
#' function from the roxygen2 package. See the documentation and vignettes of
#' that package to learn how to use roxygen.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @inheritParams roxygen2::roxygenise
#' @seealso \code{\link[roxygen2]{roxygenize}},
#'   \code{browseVignettes("roxygen2")}
#' @export
document <- function(pkg = ".", roclets = NULL) {
  check_suggested("roxygen2")

  pkg <- as.package(pkg)
  message("Updating ", pkg$package, " documentation")

  save_all()

  withr::with_envvar(r_env_vars(), roxygen2::roxygenise(pkg$path, roclets))

  pkgload::dev_topic_index_reset(pkg$package)
  invisible()
}
