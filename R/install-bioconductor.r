#' Install packages from SVN on bioconductor
#'
#' This function installs the latest development version of the packages,
#' which is useful for testing purposes.
#' In contrast, the \code{biocLite()} function provided by bioconductor
#' installs a stable (hence usually older) version, which should be preferred
#' for production work.
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
#' @importFrom httr stop_for_status content HEAD GET authenticate
#' @importFrom stringr str_c str_replace str_detect str_extract_all fixed
install_bioconductor <- function(pkgs, ...) {

  # prepare connection
  user <- "readonly"
  password <- "readonly"
  auth <- authenticate(user=user, password=password)
  base <- "https://hedgehog.fhcrc.org/bioconductor/trunk/madman/Rpacks"

  for (pkg in pkgs) {

    # prepare URL
    url <- str_c(base, pkg, sep="/")

    # check that the package exists
    # TODO replace by url_ok() from httr
    status <- HEAD(url=url, config=auth)$status_code
    if (status != 200) {
      warning("Package ", pkg, " not found on bioconductor")
      next()
    }

    # create a temporary directory to hold the package content
    temp <- file.path(tempfile(), pkg)

    # get all packages files
    message("Downloading ", pkg)
    spider_svn(url=url, destdir=temp, config=auth)

    # install package
    install(pkg=temp, ...)

    # remove temporary files
    unlink(temp, recursive=TRUE)
  }

  return(invisible(TRUE))
}


# Walk the listing of a subversion http interface and download all files
# url       URL of the SVN repository web interface
# destdir   destination of the downloaded files
# ...       passed to GET
spider_svn <- function(url, destdir, ...) {

  # download the content of the page
  page <- text_content(GET(url, ...))

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
    req <- GET(url=str_c(url, "/", file), ...)
    stop_for_status(req)
    writeBin(content(req), con=file.path(destdir, file))
  }

  # walk dirs and download their content too
  for (dir in dirs) {
    spider_svn(url=str_c(url, "/", dir, "/"), destdir=file.path(destdir, dir), ...)
  }

  return(invisible(TRUE))
}

