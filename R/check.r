#' Build and check a package, cleaning up automatically on success.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
check <- function(pkg) {
  pkg <- as.package(pkg)
  
  in_dir(dirname(pkg$path), {
    targz <- paste(pkg$package, "_", pkg$version, ".tar.gz", sep = "")
    
    system(paste("R CMD build ", shQuote(basename(pkg$path)), sep = ""))
    res <- system(paste("R CMD check ", targz, sep = ""))
    
    if (res != 0) {
      stop("R CMD check ", shQuote(pkg$package), " failed", call. = FALSE, 
        sep = "")
    }
    
    unlink(targz)
    unlink(paste(pkg$package, ".Rcheck", sep = ""))
  })  
}
