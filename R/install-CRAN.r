#' Attempts to install a package from CRAN.
#'
#' This function is vectorised on \code{pkgs} so you can install multiple
#' packages in a single command.
#'
#' @param pkgs Character vector of packages to install.
#' @inheritParams package_deps
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_CRAN("ggplot2")
#' install_CRAN(c("httpuv", "shiny")
#' }
install_CRAN <- function(pkgs, repos = getOption("repos"), type = getOption("pkgType"), ..., quiet = FALSE) {

  remotes <- lapply(pkgs, CRAN_remote, repos = repos, type = type)

  install_remotes(remotes, quiet = quiet, ...)
}

CRAN_remote <- function(pkg, repos, type) {

  remote("CRAN",
    name = pkg,
    repos = repos,
    pkg_type = type)
}


#' @export
remote_download.CRAN_remote <- function(x, quiet = FALSE) {
  dest_dir <- tempdir()
  download.packages(x$name, destdir = dest_dir, repos = x$repos, type = x$pkg_type)[1, 2]
}

#' @export
remote_metadata.CRAN_remote <- function(x, bundle = NULL, source = NULL) {
  version <- read_dcf(file.path(source, "DESCRIPTION"))$Version
  list(
    RemoteType = "CRAN",
    RemoteSha = version,
    RemoteRepos = deparse(x$repos),
    RemotePkgType = x$pkg_type
  )
}

#' @export
remote_package_name.CRAN_remote <- function(remote, ...) {
  remote$name
}

#' @export
remote_sha.CRAN_remote <- function(remote, url = "https://github.com", ...) {
  cran <- available_packages(remote$repos, remote$pkg_type)

  tryCatch(cran[remote$name, "Version"], error = function(e) NA)
}
