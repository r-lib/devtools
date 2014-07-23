#' Use roxygen to document a package.
#'
#' This function is a wrapper for the \code{\link[roxygen2]{roxygenize}()}
#' from the roxygen2 package. See the documentation and vignettes of
#' that package to learn how to use roxygen.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param clean,reload Deprecated.
#' @inheritParams roxygen2::roxygenise
#' @seealso \code{\link[roxygen2]{roxygenize}},
#'   \code{browseVignettes("roxygen2")}
#' @export
document <- function(pkg = ".", clean = NULL, roclets = NULL, reload = TRUE) {
  if (!missing(clean)) {
    warning("Clean argument deprecated: roxygen2 now automatically cleans up",
      call. = FALSE)
  }
  if (!is_installed("roxygen2", 4)) {
    stop("Please install latest roxygen2", call. = FALSE)
  }

  pkg <- as.package(pkg)
  message("Updating ", pkg$package, " documentation")

  if (!is_loaded(pkg) || (is_loaded(pkg) && reload)) {
    load_all(pkg)
  }
  with_envvar(r_env_vars(),
    roxygen2::roxygenise(pkg$path, roclets = roclets, load_code = ns_env)
  )

  clear_topic_index(pkg)
  invisible()
}
