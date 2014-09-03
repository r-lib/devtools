#' Attempts to install a package directly from gitorious.
#'
#' This function is vectorised so you can install multiple packages in
#' a single command.
#'
#' @inheritParams install_github
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_gitorious("r-mpc-package/r-mpc-package")
#' }
install_gitorious <- function(repo, ref = "master", subdir = NULL, ...) {
  remotes <- lapply(repo, gitorious_remote, ref = ref, subdir = subdir)

  install_remotes(remotes, ...)
}

gitorious_remote <- function(repo, ref = NULL, subdir = NULL, sha = NULL) {
  meta <- parse_git_repo(repo)

  remote("gitorious",
    repo = meta$repo,
    subdir = meta$subdir %||% subdir,
    username = meta$username,
    ref = meta$ref %||% ref,
    sha = sha
  )
}

#' @export
remote_download.gitorious_remote <- function(x, quiet = FALSE) {
  if (!quiet) {
    message("Downloading gitorious repo ", x$username, "/", x$repo, "@", x$ref)
  }

  dest <- tempfile(fileext = paste0(".tar.gz"))

  src <- paste("https://gitorious.org/", x$username, "/", x$repo,
    "/archive-tarball/", x$ref, sep = "")

  download(dest, src)
}

#' @export
remote_metadata.gitorious_remote <- function(x, bundle = NULL, source = NULL) {
  if (!is.null(x$sha)) {
    # Might be cached already (because re-installing)
    sha <- x$sha
  } else {
    sha <- NULL
  }

  list(
    RemoteType = "gitorious",
    RemoteRepo = x$repo,
    RemoteUsername = x$username,
    RemoteRef = x$ref,
    RemoteSha = sha,
    RemoteSubdir = x$subdir
  )
}

