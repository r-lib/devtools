#' Environment variables to set when calling R
#'
#' Devtools sets a number of environmental variables to ensure consistent
#' between the current R session and the new session, and to ensure that
#' everything behaves the same across systems. It also suppresses a common
#' warning on windows, and sets `NOT_CRAN` so you can tell that your
#' code is not running on CRAN. If `NOT_CRAN` has been set externally, it
#' is not overwritten.
#'
#' @keywords internal
#' @return a named character vector
#' @export
r_env_vars <- function() {
  vars <- c(
    "R_LIBS" = paste(.libPaths(), collapse = .Platform$path.sep),
    "CYGWIN" = "nodosfilewarning",
    # When R CMD check runs tests, it sets R_TESTS. When the tests
    # themselves run R CMD xxxx, as is the case with the tests in
    # devtools, having R_TESTS set causes errors because it confuses
    # the R subprocesses. Un-setting it here avoids those problems.
    "R_TESTS" = "",
    "R_BROWSER" = "false",
    "R_PDFVIEWER" = "false"
  )

  if (is.na(Sys.getenv("NOT_CRAN", unset = NA))) {
    vars[["NOT_CRAN"]] <- "true"
  }

  vars
}
