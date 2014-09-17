#' Build the development version of devtools from GitHub.
#'
#' This function is especially useful for Windows users who want to upgrade
#' their version of devtools to the development version hosted on on GitHub.
#' In Windows, it's not possible to upgrade devtools while the package is loaded
#' because there is an open DLL, which in Windows can't be overwritten. This
#' function allows you to build a binary package of the development version of
#' devtools; then you can restart R (so that devtools isn't loaded) and install
#' the package.
#'
#' Mac and Linux users don't need this function; they can use
#' \code{\link{install_github}} to install devtools directly, without going
#' through the separate build-restart-install steps.
#'
#' This function requires a working development environment. On Windows, it
#' needs \url{http://cran.r-project.org/bin/windows/Rtools/}.
#'
#' @param outfile The name of the output file. If NULL (the default), it uses
#'   ./devtools.tgz (Mac and Linux), or ./devtools.zip (Windows).
#' @return a string giving the location (including file name) of the built
#'  package
#' @examples
#' \dontrun{
#' library(devtools)
#' build_github_devtools()
#'
#' #### Restart R before continuing ####
#' install.packages("./devtools.zip", repos = NULL)
#'
#' # Remove the package after installation
#' unlink("./devtools.zip")
#' }
#' @export
build_github_devtools <- function(outfile = NULL) {
  if (!has_devel()) {
    stop("This requires a working development environment.")
  }

  ext <- if (.Platform$OS.type == "windows") "zip" else "tgz"
  outfile <- paste0("./devtools.", ext)

  url <- "https://github.com/hadley/devtools/archive/master.zip"
  message("Downloading devtools from ", url)
  bundle <- file.path(tempdir(), "devtools-master.zip")

  # Download package file
  request <- httr::GET(url)
  httr::stop_for_status(request)
  writeBin(httr::content(request, "raw"), bundle)
  on.exit(unlink(bundle))

  unzip(bundle, exdir = tempdir())

  # Build binary package
  pkgdir <- file.path(tempdir(), "devtools-master")
  built_pkg <- devtools::build(pkgdir, binary = TRUE)

  message("Renaming file to ", outfile)
  file.rename(built_pkg, outfile)

  invisible(outfile)
}
