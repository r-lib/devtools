#' Install a package.
#'
#' Uses \code{R CMD install} to install the package. Will also try to install
#' dependencies of the package from CRAN, if they're not already installed.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @export
install <- function(pkg) {
  pkg <- as.package(pkg)
  install_deps(pkg)  
  
  in_dir(dirname(pkg$path), {
    system(paste("R CMD INSTALL ", shQuote(basename(pkg$path)), sep = ""))    
  })
}

install_deps <- function(pkg) {
  pkg <- as.package(pkg)
  deps <- c(parse_deps(pkg$depends), parse_deps(pkg$imports), 
    parse_deps(pkg$suggests), parse_deps(pkg$enhances),
    parse_deps(pkg$linkingto))
  
  # Remove packages that are already installed
  not.installed <- function(x) length(find.package(x, quiet = TRUE)) == 0
  deps <- Filter(not.installed, deps)
  
  if (length(deps) == 0) return(invisible())
  
  message("Installing dependencies: ", paste(deps, collapse = ", "))
  install.packages(deps)
  invisible(deps)
}