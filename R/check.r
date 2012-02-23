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
#' @param cleanup if \code{TRUE} the check directory is removed if the check
#'   is successful - this allows you to inspect the results to figure out what
#'   went wrong. If \code{FALSE} the check directory is never removed.
#' @export
check <- function(pkg = NULL, document = TRUE, cleanup = TRUE) {
  pkg <- as.package(pkg)
  
  if (document) {
    document(pkg, clean = TRUE)
  }
  message("Checking ", pkg$package)

  built_path <- build(pkg, tempdir())  
  on.exit(unlink(built_path))
  
  R(paste("CMD check ", built_path, " --timings", sep = ""), tempdir())
  
  check_path <- file.path(tempdir(), paste(pkg$package, ".Rcheck", 
    sep = ""))
  if (cleanup) {
    unlink(check_path, recursive = TRUE)    
  } else {
    message("Check results in ", check_path)
  }

  invisible(TRUE)
}


#' Check a package from CRAN.
#'
#' This is useful for automatically checking that dependencies of your 
#' packages work.
#'
#' The downloaded package and check directory are only removed if the check is
#' successful - this allows you to inspect the results to figure out what
#' went wrong.
#'
#' @param pkg Package name - note that unlike other \pkg{devtools} functions
#'   this is the name of a CRAN package, not a path.
#' @param ... other parameters passed onto \code{\link{download.packages}}
#' @export
check_cran <- function(pkg, ...) {
  message("Checking CRAN package ", pkg)

  tmp <- tempdir()
  stopifnot(is.character(pkg) && length(pkg) == 1)
  
  downloaded <- download.packages(pkg, tmp, type = "source", quiet = TRUE,
    ...)
  out_path <- downloaded[1,2]
  check_path <- gsub("_.*?$", ".Rcheck", out_path)
  
  R(paste("CMD check ", out_path, sep = ""), tempdir())

  unlink(out_path)
  unlink(check_path, recursive = TRUE)
  
  invisible(TRUE)
}
