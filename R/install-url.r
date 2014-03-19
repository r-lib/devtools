#' Install a package from a url
#'
#' This function is vectorised so you can install multiple packages in
#' a single command.
#'
#' @param url location of package on internet. The url should point to a
#'   zip file, a tar file or a bzipped/gzipped tar file.
#' @param name optional package name, used to provide more informative
#'   messages
#' @param subdir subdirectory within url bundle that contains the R package.
#' @param config additional configuration argument (e.g. proxy,
#'   authentication) passed on to \code{\link[httr]{GET}}.
#' @param before_install a function that can modify the contents of the package
#'   source directory prior to installation. Accepts two parameters: bundle (the
#'   full path to the downloaded package zip file) and pkg_path (the path where
#'   the package source is staged prior to installation)
#' @param ... Other arguments passed on to \code{\link{install}}.
#' @export
#' @family package installation
install_url <- function(url, name = NULL, subdir = NULL, config = list(), before_install = NULL, ...) {
  if (is.null(name)) {
    name <- rep(list(NULL), length(url))
  }

  invisible(mapply(install_url_single, url, name,
    MoreArgs = list(subdir = subdir, config = config, before_install = before_install, ...)))
}

#' @importFrom httr GET config stop_for_status content
install_url_single <- function(url, name = NULL, subdir = NULL, config = list(), before_install = NULL, ...) {
  if (is.null(name)) {
    name <- basename(url)
  }

  message("Downloading ", name, " from ", url)
  bundle <- file.path(tempdir(), name)

  # Download package file
  request <- GET(url, config)
  stop_for_status(request)
  writeBin(content(request), bundle)
  on.exit(unlink(bundle), add = TRUE)

  # Install local file
  install_local_single(bundle, subdir = subdir, before_install = before_install, ...)
}
