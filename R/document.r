#' Use roxygen to document a package.
#'
#' This function is a wrapper for the \code{\link[roxygen2]{roxygenize}()}
#' function from the roxygen2 package. See the documentation and vignettes of
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
  check_suggested("roxygen2")
  if (!missing(clean)) {
    warning("`clean` is deprecated: roxygen2 now automatically cleans up",
      call. = FALSE)
  }
  if (!missing(reload)) {
    warning("`reload` is deprecated: code is now always reloaded", call. = FALSE)
  }

  pkg <- as.package(pkg)
  message("Updating ", pkg$package, " documentation")

  load_all(pkg)

  if (packageVersion("roxygen2") > "4.1.1") {
    roclets <- roclets %||% roxygen2::load_options(pkg$path)$roclets
    # collate updated by load_all()
    roclets <- setdiff(roclets, "collate")
  }

  withr::with_envvar(r_env_vars(),
    roxygen2::roxygenise(pkg$path, roclets = roclets, load_code = ns_env)
  )

  clear_topic_index(pkg)
  invisible()
}
