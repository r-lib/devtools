#' Install a package.
#'
#' Uses \code{R CMD install} to install the package.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
install <- function(pkg) {
  pkg <- as.package(pkg)
  
  in_dir(dirname(pkg$path), {
    system(paste("R CMD INSTALL ", basename(pkg$path), sep = ""))    
  })  
}
