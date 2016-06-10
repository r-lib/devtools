#' Install a package directly from bitbucket
#'
#' This function is vectorised so you can install multiple packages in
#' a single command.
#'
#' To install from a private repo, or more generally, access the Bitbucket API
#' with your own credentials, you will need to get an access token. You can
#' create an access token following the instructions found in the
#' \href{https://confluence.atlassian.com/bitbucket/app-passwords-828781300.html}{Bitbucket App Passwords documentation}.
#' This PAT requires read-only access to your repositories and pull requests.
#'
#' @inheritParams install_github
#' @param auth_token see \code{Details} section. PATs can be created at
#'   \url{https://bitbucket.org/account/admin/app-passwords}
#' @param ref Desired git reference. Could be a commit, tag, or branch
#'   name, or a call to \code{\link{bitbucket_pull}}. Defaults to \code{"master"}.
#' @family package installation
#' @export
#' @examples
#' \dontrun{
#' install_bitbucket("dannavarro/lsr-package")
#' }
install_bitbucket <- function(repo, username = NULL, ref = "master",
  subdir = NULL, auth_token = bitbucket_pat(),
  host = "https://api.bitbucket.org", quiet = FALSE, ...) {

  remotes <- lapply(repo, bitbucket_remote, username = username, ref = ref,
    subdir = subdir, auth_token = auth_token, host = host)

  install_remotes(remotes, quiet = quiet, ...)
}

bitbucket_remote <- function(repo, username = NULL, ref = NULL, subdir = NULL,
  auth_token = bitbucket_pat(), sha = NULL, host = "https://api.bitbucket.org") {

  meta <- parse_git_repo(repo)
  meta <- resolve_ref(meta$ref %||% ref, meta)

  if (is.null(meta$username)) {
    meta$username <- username %||% stop("Unknown username.")
    warning("Username parameter is deprecated. Please use ",
      username, "/", repo, call. = FALSE)
  }

  remote("bitbucket",
    host = host,
    repo = meta$repo,
    subdir = meta$subdir %||% subdir,
    username = meta$username,
    ref = meta$ref,
    sha = sha,
    auth_token = auth_token
  )
}

#' @export
remote_download.bitbucket_remote <- function(x, quiet = FALSE) {
  if (!quiet) {
    message("Downloading bitbucket repo ", x$username, "/", x$repo, "@", x$ref)
  }

  dest <- tempfile(fileext = paste0(".zip"))
  src <- paste("https://bitbucket.org/", x$username, "/", tolower(x$repo), "/get/",
    x$ref, ".zip", sep = "")

  if (!is.null(x$password)) {
    auth <- httr::authenticate(
      user = x$auth_user %||% x$username,
      password = x$password,
      type = "basic")
  } else {
    auth <- NULL
  }

  download(dest, src, auth)
}

#' @export
remote_metadata.bitbucket_remote <- function(x, bundle = NULL, source = NULL) {
  if (!is.null(bundle)) {
    # Might be able to get from zip archive
    sha <- git_extract_sha1(bundle)
  } else {
    # Otherwise can lookup with remote_ls
    sha <- remote_sha(x)
  }

  list(
    RemoteType = "bitbucket",
    RemoteRepo = x$repo,
    RemoteUsername = x$username,
    RemoteRef = x$ref,
    RemoteSha = sha,
    RemoteSubdir = x$subdir
  )
}

#' @export
remote_package_name.bitbucket_remote <- function(remote, ...) {
  remote_package_name.github_remote(remote, url = "https://bitbucket.org", ...)
}

#' @export
remote_sha.bitbucket_remote <-function(remote, ...) {
  remote_sha.github_remote(remote, url = "https://bitbucket.org", ...)
}

#' @export
format.bitbucket_remote <- function(x, ...) {
  "Bitbucket"
}
