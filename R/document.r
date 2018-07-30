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

  if (rstudioapi::hasFun("documentSaveAll")) {
    rstudioapi::documentSaveAll()
  }

  # Refresh the pkg structure with any updates to the Collate entry
  # in the DESCRIPTION file
  roxygen2::update_collate(pkg$path)

  roclets <- roclets %||% roxygen2::load_options(pkg$path)$roclets
  roclets <- setdiff(roclets, "collate")

  if (packageVersion("roxygen2") < "6.1.0") {
    load_all(pkg$path, helpers = FALSE)
  }

  withr::with_envvar(r_env_vars(),
    roxygen2::roxygenise(pkg$path, roclets = roclets, load_code = pkgload::pkg_ns)
  )

  pkgload::dev_topic_index_reset(pkg$package)
  invisible()
}
