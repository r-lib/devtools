#' Install a package from a url
#'
#' This function is vectorised so you can install multiple packages in
#' a single command.
#'
#' @param url location of package on internet. The url should point to a
#'   zip file, a tar file or a bzipped/gzipped tar file.
#' @param subdir subdirectory within url bundle that contains the R package.
#' @param config additional configuration argument (e.g. proxy,
#'   authentication) passed on to \code{\link[httr]{GET}}.
#' @param ... Other arguments passed on to \code{\link{install}}.
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_url("https://github.com/hadley/stringr/archive/master.zip")
#' }
install_url <- function(url, subdir = NULL, config = list(), ...) {
  remotes <- lapply(url, url_remote, subdir = subdir, config = config)
  install_remotes(remotes, ...)
}

url_remote <- function(url, subdir = NULL, config = list()) {
  remote("url",
    url = url,
    subdir = subdir,
    config = config
  )
}

#' @export
remote_download.url_remote <- function(x, quiet = FALSE) {
  if (!quiet) {
    message("Downloading package from url: ", x$url)
  }

  bundle <- tempfile(fileext = paste0(".", file_ext(x$url)))
  download(bundle, x$url, x$config)
}

#' @export
remote_metadata.url_remote <- function(x, bundle = NULL, source = NULL) {
  list(
    RemoteType = "url",
    RemoteUrl = x$url,
    RemoteSubdir = x$subdir
  )
}
