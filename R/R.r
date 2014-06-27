# R("-e 'str(as.list(Sys.getenv()))' --slave")
R <- function(options, path = tempdir(), env_vars = NULL, ...) {
  options <- paste("--vanilla", options)
  r_path <- file.path(R.home("bin"), "R")

  # If rtools has been detected, add it to the path only when running R...
  if (!is.null(get_rtools_path())) {
    old <- add_path(get_rtools_path(), 0)
    on.exit(set_path(old))
  }

  in_dir(path, system_check(r_path, options, c(r_env_vars(), env_vars), ...))
}

RCMD <- function(cmd, options, path = tempdir(), env_vars = NULL, ...) {
  options <- paste(options, collapse = " ")
  R(paste("CMD", cmd, options), path = path, env_vars = env_vars, ...)
}

#' Environment variables to set when calling R
#'
#' Devtools sets a number of environmental variables to ensure consistent
#' between the current R session and the new session, and to ensure that
#' everying behaves the same across systems. It also suppresses a common
#' warning on windows, and sets \code{NOT_CRAN} so you can tell that your
#' code is not running on CRAN.
#'
#' @keywords internal
#' @return a named character vector
#' @export
r_env_vars <- function() {
  c("R_LIBS" = paste(.libPaths(), collapse = .Platform$path.sep),
    "CYGWIN" = "nodosfilewarning",
    # When R CMD check runs tests, it sets R_TESTS. When the tests
    # themeselves run R CMD xxxx, as is the case with the tests in
    # devtools, having R_TESTS set causes errors because it confuses
    # the R subprocesses. Unsetting it here avoids those problems.
    "R_TESTS" = "",
    "NOT_CRAN" = "true",
    "TAR" = auto_tar())
}

# Determine the best setting for the TAR environmental variable
# This is needed for R <= 2.15.2 to use internal tar. Later versions don't need
# this workaround, and they use R_BUILD_TAR instead of TAR, so this has no
# effect on them.
auto_tar <- function() {
  tar <- Sys.getenv("TAR", unset = NA)
  if (!is.na(tar)) return(tar)

  windows <- .Platform$OS.type == "windows"
  no_rtools <- is.null(get_rtools_path())
  if (windows && no_rtools) "internal" else ""
}

