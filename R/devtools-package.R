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
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom lifecycle deprecated
## usethis namespace: end
NULL
