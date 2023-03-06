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
#' }
#' @docType package
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @import rlang
#' @importFrom glue glue
#' @importFrom lifecycle deprecated
#' @importFrom miniUI miniPage
#' @importFrom profvis profvis
#' @importFrom urlchecker url_check
## usethis namespace: end
NULL
