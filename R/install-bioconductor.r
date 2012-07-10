#' Install a package from SVN on bioconductor
#'
#' This function fetches the latest development version of each package,
#' for testing purposes.
#' In contrast, the \code{biocLite()} function provided by bioconductor
#' installs a stable (hence usually older) version.
#' It is vectorised so you can install multiple packages in
#' a single command.
#'
#' Please note that the function has to download each file of the package
#' separately from bioconductor, hence the download phase can be quite long.
#'
#' @param pkgs vector of packages names
#' @param ... further arguments passed to \code{\link{install}}
#' @family package installation
#' @export
#' @examples
#' \dontrun{install_bioconductor(pkgs=c("ggbio", "pcaMethods"))
#' }
#' @importFrom httr set_config reset_config stop_for_status content HEAD GET authenticate handle
#' @importFrom stringr str_c str_replace str_detect str_extract_all fixed
install_bioconductor <- function(pkgs, ...) {

  # prepare connection
	set_config(authenticate("readonly", "readonly"))
  domain <- "https://hedgehog.fhcrc.org"
  base <- "bioconductor/trunk/madman/Rpacks"
	h <- handle(domain)

  for (pkg in pkgs) {

    # prepare URL
    path <- str_c(base, pkg, sep="/")

    # check that the package exists
    status <- HEAD(handle=h, path=path)$status_code
    if (status >= 300) {
      next("Package not found on bioconductor")
    }

    # create a temporary directory to hold the package content
    # temp <- str_c(tempfile(), "/", pkg, "/")
    temp <- str_c("~/Downloads", "/", pkg, "/") # !!! Warning, FOR NOW

    # get all packages files
    message("Downloading ", pkg)
    download_subversion_listing(handle=h, path=path, destdir=temp)

    # install package
    install(pkg=temp, ...)

    # remove temporary files
    unlink(temp, recursive=TRUE)
  }

  # reset RCurl options
	on.exit(expr=reset_config())

  return(invisible(TRUE))
}


# Walk the listing of the subversion http interface and download all files
# handle    connection handle to bioconductor (contains url)
# path      location on the bioconductor server
# destdir   destination of the downloaded files
download_subversion_listing <- function(handle, path, destdir, ...) {

  # download the content of the page
  page <- text_content(GET(handle=handle, path=path))

  # get all links
  links <- str_extract_all(page, pattern="href=\".*?\"")[[1]]

  # suppress "../" and subversion links
  links <- links[!str_detect(links, fixed("../"))]
  links <- links[!str_detect(links, fixed("http://subversion.tigris.org/"))]

  # clean addresses
  links <- str_replace(links, fixed("href=\""), "")
  links <- str_replace(links, fixed("\""), "")

  # separate dirs from files
  hasDirMark <- str_detect(links, fixed("/"))
  dirs <- links[hasDirMark]
  files <- links[!hasDirMark]

  # create destdir if need be
  dir.create(destdir, showWarnings=FALSE, recursive=TRUE)

  # download files
  for (file in files) {
    req <- GET(handle=handle, path=str_c(path, "/", file))
    stop_for_status(req)
    writeBin(content(req), con=str_c(destdir, "/", file))
  }

  # walk dirs and download their content too
  for (dir in dirs) {
    download_subversion_listing(handle=handle, path=str_c(path, "/", dir), destdir=str_c(destdir, "/", dir), ...)
  }

  return(invisible(TRUE))
}

