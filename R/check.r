#' Build and check a package, cleaning up automatically on success.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
check <- function(pkg = NULL) {
  pkg <- as.package(pkg)
  message("Checking ", pkg$package)
  
  in_dir(dirname(pkg$path), {
    targz <- paste(pkg$package, "_", pkg$version, ".tar.gz", sep = "")
    
    system_check(paste("R CMD build ", shQuote(basename(pkg$path)), sep = ""))
    on.exit(unlink(targz))
    
    system_check(paste("R CMD check ", targz, sep = ""))
    unlink(paste(pkg$package, ".Rcheck", sep = ""))
  })
  invisible(TRUE)
}
