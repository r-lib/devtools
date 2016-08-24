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
#' install_cran("ggplot2")
#' install_cran(c("httpuv", "shiny")
#' }
install_cran <- function(pkgs, repos = getOption("repos"), type = getOption("pkgType"), ..., quiet = FALSE) {

  remotes <- lapply(pkgs, cran_remote, repos = repos, type = type)

  install_remotes(remotes, quiet = quiet, ...)
}

cran_remote <- function(pkg, repos, type) {

  remote("cran",
    name = pkg,
    repos = repos,
    pkg_type = type)
}


#' @export
#' @importFrom utils download.packages
remote_download.cran_remote <- function(x, quiet = FALSE) {
  dest_dir <- tempdir()

  # download.packages() doesn't fully respect "quiet" argument
  if (quiet) {
    sink_file <- tempfile()
    path <- withr::with_message_sink(
      sink_file,
      download_cran(x, quiet, dest_dir)
    )
  } else {
    path <- download_cran(x, quiet, dest_dir)
  }

  # Make sure we return a copy which can be deleted later on
  # (e.g., for local repositories)
  if (dirname(normalizePath(path)) != normalizePath(dest_dir)) {
    file.copy(path, dest_dir)
    path <- file.path(dest_dir, basename(path))
  }

  path
}

download_cran <- function(x, quiet, dest_dir) {
  download.packages(x$name, destdir = dest_dir, repos = x$repos, type = x$pkg_type, quiet = quiet)[1, 2]
}

#' @export
remote_metadata.cran_remote <- function(x, bundle = NULL, source = NULL) {
  version <- read_dcf(file.path(source, "DESCRIPTION"))$Version
  list(
    RemoteType = "cran",
    RemoteSha = trimws(version),
    RemoteRepos = paste0(deparse(x$repos), collapse = ""),
    RemotePkgType = x$pkg_type
  )
}

#' @export
remote_package_name.cran_remote <- function(remote, ...) {
  remote$name
}

#' @export
remote_sha.cran_remote <- function(remote, url = "https://github.com", ...) {
  cran <- available_packages(remote$repos, remote$pkg_type)

  trimws(unname(cran[, "Version"][match(remote$name, rownames(cran))]))
}

#' @export
format.cran_remote <- function(x, ...) {
  "CRAN"
}
