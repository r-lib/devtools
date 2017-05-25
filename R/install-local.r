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
install_local <- function(path, subdir = NULL, ..., quiet = FALSE) {
  remotes <- lapply(path, local_remote, subdir = subdir)
  install_remotes(remotes, ..., quiet = quiet)
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
  res <- list(
    RemoteType = "local",
    RemoteUrl = x$path
  )

  res$RemoteSha <- remote_sha.local_remote(x)
  if (uses_git(x$path)) {
    res$RemoteBranch <- git_branch(path = x$path)
  }
  if (uses_github(x$path)) {
    info <- github_info(x$path)
    res$RemoteUsername <- info$username
    res$RemoteRepo <- info$repo
  }
  res
}

#' @export
remote_metadata.package <- remote_metadata.local_remote

#' @export
remote_package_name.local_remote <- function(remote, ...) {
  description_path <- file.path(remote$path, "DESCRIPTION")

  read_dcf(description_path)$Package
}

#' @export
remote_sha.local_remote <- function(remote, ...) {
  if (uses_git(remote$path)) {
    if (git_uncommitted(remote$path)) {
      return(NA_character_)
    }
    tryCatch({
      git_sha1(path = remote$path)
    }, error = function(e) NA_character_)
  } else {
    read_dcf(file.path(remote$path, "DESCRIPTION"))$Version
  }
}

#' @export
format.local_remote <- function(x, ...) {
  "local"
}
