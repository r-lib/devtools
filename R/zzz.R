#' @importFrom utils available.packages contrib.url install.packages
#'   installed.packages modifyList packageDescription
#'   packageVersion remove.packages
#' @importFrom cli cat_rule cat_line cat_bullet
#' @importFrom pkgbuild find_rtools
NULL

#' Package development tools for R.
#'
#' @section Package options:
#'
#' Devtools uses the following [options()] to configure behaviour:
#'
#' \itemize{
#'   \item `devtools.path`: path to use for [dev_mode()]
#'
#'   \item `devtools.name`: your name, used when signing draft
#'     emails.
#'
#'   \item `devtools.install.args`: a string giving extra arguments passed
#'     to `R CMD install` by [install()].
#'
#'   \item `devtools.desc.author`: a string providing a default Authors@@R
#'     string to be used in new \file{DESCRIPTION}s.  Should be a R code, and
#'     look like `"Hadley Wickham <h.wickham@@gmail.com> [aut, cre]"`. See
#'     [utils::as.person()] for more details.
#'
#'   \item `devtools.desc.license`: a default license string to use for
#'     new packages.
#'
#'   \item `devtools.desc.suggests`: a character vector listing packages to
#'     to add to suggests by defaults for new packages.
#
#'   \item `devtools.desc`: a named list listing any other
#'     extra options to add to \file{DESCRIPTION}
#'
#' }
#' @docType package
#' @name devtools
"_PACKAGE"

#' Deprecated Functions
#'
#' These functions are Deprecated in this release of devtools, they will be
#' marked as Defunct and removed in a future version.
#' @name devtools-deprecated
#' @keywords internal
NULL

devtools_default_options <- list(
  devtools.path = "~/R-dev",
  devtools.install.args = "",
  devtools.name = "Your name goes here",
  devtools.desc.author = 'person("First", "Last", email = "first.last@example.com", role = c("aut", "cre"))',
  devtools.desc.license = "What license is it under?",
  devtools.desc.suggests = NULL,
  devtools.desc = list(),
  devtools.revdep.libpath = file.path(tempdir(), "R-lib")
)

.onLoad <- function(libname, pkgname) {
  op <- options()
  toset <- !(names(devtools_default_options) %in% names(op))
  if (any(toset)) options(devtools_default_options[toset])

  invisible()
}

.onAttach <- function(libname, pkgname) {
  env <- as.environment(paste0("package:", pkgname))
  env[[".conflicts.OK"]] <- TRUE
  suppressPackageStartupMessages((get("library", baseenv()))("usethis"))
}
