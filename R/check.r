#' Build and check a package, cleaning up automatically on success.
#'
#' \code{check} automatically builds a package before using \code{R CMD check}
#' as this is the recommended way to check packages.  Note that this process
#' runs in an independent realisation of R, so nothing in your current 
#' workspace will affect the process.
#'
#' After the \code{R CMD check}, this will run checks that are specific
#' to devtools.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param document if \code{TRUE} (the default), will update and check
#'   documentation before running formal check.
#' @param cleanup if \code{TRUE} the check directory is removed if the check
#'   is successful - this allows you to inspect the results to figure out what
#'   went wrong. If \code{FALSE} the check directory is never removed.
#' @param cran if \code{TRUE} (the default), check with CRAN.
#' @param args An optional character vector of additional command line
#'   arguments to be passed to \code{R CMD check}.
#' @export
check <- function(pkg = ".", document = TRUE, cleanup = TRUE,
  cran = TRUE, args = NULL) {
  pkg <- as.package(pkg)
  
  if (document) {
    document(pkg, clean = TRUE)
  }

  built_path <- build(pkg, tempdir())  
  on.exit(unlink(built_path))

  r_cmd_check_path <- check_r_cmd(pkg, built_path, cran, args)

  check_devtools(pkg, built_path)
  

  if (cleanup) {
    unlink(r_cmd_check_path, recursive = TRUE)
  } else {
    message("R CMD check results in ", r_cmd_check_path)
  }

  invisible(TRUE)
}


# Run R CMD check and return the path for the check
# @param built_path The path to the built .tar.gz source package.
check_r_cmd <- function(pkg = ".", built_path = NULL, cran = TRUE,
  args = NULL) {

  pkg <- as.package(pkg)
  message("Checking ", pkg$package, " with R CMD check")

  opts <- "--timings"
  if (cran)
    opts <- c(opts, "--as-cran")
  opts <- paste(paste(opts, collapse = " "), paste(args, collapse = " "))

  R(paste("CMD check ", shQuote(built_path), " ", opts, sep = ""), tempdir())

  # Return the path to the check output
  file.path(tempdir(), paste(pkg$package, ".Rcheck", sep = ""))
}
