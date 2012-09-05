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
#' @param archive_structure Does the repository have a defined archive structure?
#'   When TRUE, the function  looks for older versions of packages in
#'   the src/contrib/Archive/packageName directory of the repository, like 
#'   on CRAN. Setting this to FALSE indicates that all versions of all packages
#'   are located in the src/contrib directory of the repository, which is
#'   usually the case of custom repositories.
#' @param ... Other arguments passed on to \code{\link{install}}.
#' @inheritParams utils::install.packages
#' @author Jeremy Stephens
install_version <- function(package, version = NULL, repos = getOption("repos"), type = getOption("pkgType"), archive_structure=TRUE, ...) {
  
  contriburl <- contrib.url(repos, type)
  available <- available.packages(contriburl)
  
  if (!is.null(version)) {
    version <- numeric_version(version)
  }
  
  if (package %in% row.names(available)) {
    current.version <- available[package, 'Version']
    if (is.null(version) || version == current.version) {
      return(install.packages(package, repos = repos, contriburl = contriburl,
        type = type, ...))
    }
  }

  if (archive_structure) {
    con <- gzcon(url(sprintf("%s/src/contrib/Archive.rds", repos), "rb"))
    on.exit(close(con))
    archive <- readRDS(con)
    info <- archive[[package]]
  } else {
    available.all <- available.packages(sprintf("%s/src/contrib", repos), filters=c('OS_type', 'subarch'))
    available.all <- available.all[row.names(available.all) == package, c('Package', 'Version'), drop=FALSE]
    info <- if (nrow(available.all) == 0) NULL else sprintf('%s_%s.tar.gz', available.all[, 'Package'], available.all[, 'Version'])
  }

  if (is.null(info)) {
    stop(sprintf("Couldn't find package '%s'.", package))
  }

  # Shouldn't this never trigger? I suppose it will iff a package is in the Archive directory 
  # but not listed in  available.packages, which means someone wants to install a deprecated package.
  # Is that even a valid use case? I'm thinking we should remove this if structure if so.
  if (is.null(version)) {
    # Grab the latest one
    # actually, this grabs the second to last one when archive_structure == TRUE, 
    # since the latest version isn't listed in Archive.rds 
    package.path <- info[length(info)]
  } else {
    directory.path <- if(archive_structure) paste(package, "/", sep="") else ""
    package.path <- paste(directory.path, package, "_", version, ".tar.gz", sep="")
    if (!(package.path %in% info)) {
      stop(sprintf("Version '%s' is invalid for package '%s'. Valid versions are: %s.", version,
        package, paste(gsub(sprintf("%s|/|_|.tar.gz", package), "", info), collapse=', ')))
    }
  }

  archive.path <- sprintf("/src/contrib/%s", if (archive_structure) "Archive/" else "")
  url <- paste(repos, archive.path, package.path, sep = "")
  install_url(url, ...)
}
