#' Install specified version of a CRAN package.
#'
#' If you are installing an package that contains compiled code, you will 
#' need to have an R development environment installed.  You can check
#' if you do by running \code{\link{has_devel}}.
#'
#' @export
#' @family package installation
#' @param package package name
#' @param version If the specified version is NULL or the same as the most
#'   recent version of the package, this function simply calls
#'   \code{\link{install.packages}}. Otherwise, it looks at the list of
#'   archived source tarballs and tries to install an older version instead.
#' @param as.of.date If the specified date is not NULL and version is NULL,
#'   attempt to find the package version as of a certain date.
#' @inheritParams utils::install.packages
#' @author Jeremy Stephens
install_version <- function(package, version = NULL, as.of.date = NULL, repos = getOption("repos"), type = getOption("pkgType")) {
  
  contriburl <- contrib.url(repos, type)
  available <- available.packages(contriburl)
  
  if (!is.null(version)) {
    version <- numeric_version(version)

    # always override date with version
    as.of.date <- NULL
  }
  else if (!is.null(as.of.date)) {
    as.of.date <- as.Date(as.of.date)
  }

  if (package %in% row.names(available)) {
    if (!is.null(as.of.date)) {
      dcon <- url(sprintf("%s/web/packages/%s/DESCRIPTION", repos, package))
      on.exit(close(dcon))
      dcf <- read.dcf(dcon)

      current.release.date <- as.Date(dcf[1, 'Date'])
      install.latest <- (as.of.date > current.release.date)
    }
    else {
      current.version <- available[package, 'Version']
      install.latest <- (is.null(version) || version == current.version)
    }

    if (install.latest) {
      return(install.packages(package, repos = repos, contriburl = contriburl,
        type = type))
    }
  }

  con <- gzcon(url(sprintf("%s/src/contrib/Archive.rds", repos), "rb"))
  on.exit(close(con))
  archive <- readRDS(con)

  info <- archive[[package]]
  if (is.null(info)) {
    stop(sprintf("couldn't find package '%s'", package))
  }

  if (!is.null(version)) {
    package.path <- paste(package, "/", package, "_", version, ".tar.gz",
      sep = "")
    if (!(package.path %in% info)) {
      stop(sprintf("version '%s' is invalid for package '%s'", version,
        package))
    }
  }
  else if (!is.null(as.of.date)) {
    # This depends on the modification time of files in the archive. The
    # alternative is to untar each file and check the DESCRIPTION file.

    package.path <- NULL
    for (i in length(info):1) {
      # Grab only the HEAD of the file (using RCurl)
      g <- basicTextGatherer()
      curl <- getCurlHandle()
      url <- paste(repos, "/src/contrib/Archive/", info[i], sep = "")

      curlPerform(url = url, followlocation = TRUE,
        headerfunction = g$update, nobody = TRUE, writefunction = g$update,
        curl = curl)
      header <- parseHTTPHeader(g$value())

      release.date <- as.Date(header['Last-Modified'], format = "%a, %d %b %Y")
      if (as.of.date >= release.date) {
        package.path <- info[i]
        break
      }
    }
    print(package.path)

    if (is.null(package.path)) {
      stop(sprintf("package '%s' didn't exist as of '%s'", package,
        as.of.date))
    }
  }
  else {
    # Grab the latest one: only happens if pulled from CRAN
    package.path <- info[length(info)]
  }

  url <- paste(repos, "/src/contrib/Archive/", package.path, sep = "")  
  install_url(url)
}
