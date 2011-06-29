#' Build and check a package, cleaning up automatically on success.
#'
#' \code{check} automatically builds a package before using \code{R CMD check}
#' as this is the recommended way to check pakcages.  Note that this process
#' runs in an independent realisation of R, so nothing in your current 
#' workspace will affect the proces.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param document if \code{TRUE} (the default), will update and check
#'   documentation before running formal check.
#' @export
check <- function(pkg = NULL, document = TRUE) {
  pkg <- as.package(pkg)
  
  document(pkg)
  message("Checking ", pkg$package)

  built_path <- build(pkg)  
  on.exit(unlink(built_path))
  
  R(paste("CMD check ", built_path, sep = ""), tempdir())
  check_path <- file.path(tempdir(), paste(pkg$package, ".Rcheck", sep = ""))
  unlink(check_path, recursive = TRUE)

  invisible(TRUE)
}
