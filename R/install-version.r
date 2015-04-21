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
#'   \code{\link{install}}. Otherwise, it looks at the list of
#'   archived source tarballs and tries to install an older version instead.
#' @param ... Other arguments passed on to \code{\link{install}}.
#' @inheritParams utils::install.packages
#' @author Jeremy Stephens
install_version <- function(package, version = NULL, repos = getOption("repos"), type = getOption("pkgType"), ...) {

  contriburl <- contrib.url(repos, type)
  available <- available.packages(contriburl)

  if (package %in% row.names(available)) {
    current.version <- available[package, 'Version']
    if (is.null(version) || version == current.version) {
      return(install.packages(package, repos = repos, contriburl = contriburl,
        type = type, ...))
    }
  }

  info <- package_find_repo(package, repos)

  if (is.null(version)) {
    # Grab the latest one: only happens if pulled from CRAN
    package.path <- info[length(info)]
  } else {
    package.path <- paste(package, "/", package, "_", version, ".tar.gz",
      sep = "")
    if (!(package.path %in% row.names(info))) {
      stop(sprintf("version '%s' is invalid for package '%s'", version,
        package))
    }
  }

  url <- paste(repos, "/src/contrib/Archive/", package.path, sep = "")
  install_url(url, ...)
}

package_find_repo <- function(package, repos) {
  for (repo in repos) {
    if (length(repos) > 1)
      message("Trying ", repo)

    con <- gzcon(url(sprintf("%s/src/contrib/Meta/archive.rds", repo), "rb"))
    on.exit(close(con))
    archive <- readRDS(con)

    info <- archive[[package]]
    if (!is.null(info))
      return(info)
  }

  stop(sprintf("couldn't find package '%s'", package))
}
