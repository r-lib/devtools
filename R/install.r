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

#' Attempts to install a package directly from github.
#'
#' @param username Github username
#' @param repo Repo name
#' @export
#' @examples
#' \dontrun{
#' install_github("roxygen")
#' }
install_github <- function(repo, username = "hadley") {
  url <- paste("http://github.com/", username, "/", repo, sep = "")
  
  # Check that this is actually an R package
  desc_url <- paste(url, "/blob/master/DESCRIPTION/raw")
  if (length(readLines(desc_url)) == 0) {
    stop("Does not appear to be an R package", call. = FALSE)
  }
  
  # Download repo zip
  name <- paste(username, "-", rep, sep = "")
  src <- file.path(tempdir(), paste(name, ".zip", sep = ""))
  download.file(paste(url, "/...zip"), src)
  on.exit(unlink(src))
  
  # Extract 
  src_dir <- file.path(tempdir(), name)
  unzip(src, exdir = src_dir)
  on.exit(unlink(src_dir), add = TRUE)
  
  # Install
  install(src_dir)
}