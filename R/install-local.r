#' Install a package from a local file
#'
#' This function is vectorised so you can install multiple packages in
#' a single command.
#'
#' @param path path to local directory, or compressed file (tar, zip, tar.gz
#'   tar.bz2, tgz2 or tbz)
#' @inheritParams install_url
#' @export
#' @examples
#' \dontrun{
#' dir <- tempfile()
#' dir.create(dir)
#' pkg <- download.packages("testthat", dir, type = "source")
#' install_local(pkg[, 2])
#' }
install_local <- function(path, subdir = NULL, ...) {
  remotes <- lapply(path, local_remote, subdir = subdir)
  install_remotes(remotes, ...)
}

local_remote <- function(path, subdir = NULL, branch = NULL, args = character(0)) {
  remote("local",
    path = path,
    subdir = subdir
  )
}

#' @export
remote_download.local_remote <- function(x, quiet = FALSE) {
  # Already downloaded - just need to copy to tempdir()
  bundle <- tempfile()
  dir.create(bundle)
  file.copy(x$path, bundle, recursive = TRUE)

  # file.copy() creates directory inside of bundle
  dir(bundle, full.names = TRUE)[1]
}

#' @export
remote_metadata.local_remote <- function(x, bundle = NULL, source = NULL) {
  list(
    RemoteType = "local",
    RemoteUrl = x$path,
    RemoteSubdir = x$subdir,
    RemoteSha = if (uses_git(x$path)) git_sha1(path = x$path)
  )
}
