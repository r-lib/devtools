#' Use roxygen to make documentation.
#'
#' This function is a wrapper for the \code{\link{roxygenize}} function
#' from the package \code{roxygen2}. 
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param clean if \code{TRUE} will automatically clear all roxygen caches
#'   and delete current \file{man/} contents to ensure that you have the
#'   freshest version of the documentation.
#' @param roclets character vector passed to roxygneise indicating roclets to update
#' valid arguments include "rd", "collate", and "namespace" 
#  and Rd files, 
#' @param reload if \code{TRUE} uses \code{load_all} to reload the package
#'   prior to documenting.  This is important because \pkg{roxygen2} uses
#'   introspection on the code objects to determine how to document them.
#' @seealso \code{\link{roxygenize}}\code{vignette("roxygen2", package = "roxygen2")}
#' @keywords programming
#' @export
document <- function(pkg = ".", clean = FALSE,
  roclets = c("collate", "namespace", "rd"), reload = TRUE) {
  if (!is_installed("roxygen2", 3)) {
    stop("Please install latest roxygen2", call. = FALSE)
  }

  pkg <- as.package(pkg)
  message("Updating ", pkg$package, " documentation")

  man_path <- file.path(pkg$path, "man")
  if (!file.exists(man_path)) dir.create(man_path)

  if (clean) {
    file.remove(dir(man_path, full.names = TRUE))
  }

  if (!is_loaded(pkg) || (is_loaded(pkg) && reload)) {
    try(load_all(pkg, reset = clean))
  }

  document_roxygen3(pkg, roclets)

  clear_topic_index(pkg)
  invisible()
}

document_roxygen3 <- function(pkg, roclets) {
  with_envvar(r_env_vars(), with_collate("C",
    roxygen2::roxygenise(pkg$path, roclets = roclets, load_code = pkg_env)
  ))
}
