#' Install a package directly from bitbucket
#'
#' This function is vectorised so you can install multiple packages in
#' a single command.
#'
#' To install from a private repo, or more generally, access the Bitbucket API
#' with your own credentials, you will need to get an access token using
#' Bitbucket's OAuth protocol. To set up the OAuth protocol dance, you will
#' need to:
#'
#' \enumerate{
#' \item Add an OAuth consumer key at
#' \code{https://bitbucket.org/account/user/<USERNAME>/api}, substituting your
#' Bitbucket user name for \code{<USERNAME>}. The consumer key \strong{Name}
#' can be anything you like (e.g. \code{RBitbucket}), the \strong{Callback URL}
#' must be \code{http://localhost:1410} and the \strong{URL} should be
#' something like \code{https://github.com/hadley/devtools}. Ensure that the
#' consumer key is private and that its \strong{scope} or \strong{Permissions}
#' only extends to "Read" access of "Repositories".
#' \item Store the resulting consumer key and secret in the environment variables
#' \code{BITBUCKET_CONSUMER_KEY} and \code{BITBUCKET_CONSUMER_SECRET} respectively.
#' See \code{\link{Startup}} for how to set up environment variables for use by
#' R. The appendix to the "httr" package's "api-packages" vignette has more
#' detailed instructions.
#' }
#'
#' The OAuth dance to get an access token will be performed When
#' \code{bitbucket_pat()} is first called and with the token cached to the
#' \code{~/.httr-oauth} file. Refreshes of this access token are performed
#' automatically.
#'
#' @inheritParams install_github
#' @param auth_token see \code{Details} section.
#' @param ref Desired git reference. Could be a commit, tag, or branch
#'   name, or a call to \code{\link{bitbucket_pull}}. Defaults to \code{"master"}.
#' @family package installation
#' @export
#' @seealso
#' \href{https://confluence.atlassian.com/bitbucket/oauth-on-bitbucket-cloud-238027431.html}{Bitbucket OAuth}
#' \href{https://confluence.atlassian.com/bitbucket/version-2-423626329.html}{Bitbucket API v2.0}
#' @examples
#' \dontrun{
#' install_bitbucket("dannavarro/lsr-package")
#' }
install_bitbucket <- function(repo, username = NULL, ref = "master",
  subdir = NULL, auth_token = bitbucket_pat(), host = bitbucket_host(),
  quiet = FALSE, ...) {

  remotes <- lapply(repo, bitbucket_remote, username = username, ref = ref,
    subdir = subdir, auth_token = auth_token, host = host)

  install_remotes(remotes, ...)
}

bitbucket_remote <- function(repo, username = NULL, ref = NULL, subdir = NULL,
  auth_token = bitbucket_pat(), host = bitbucket_host(), sha = NULL) {

  meta <- parse_bitbucket_repo(repo)
  meta <- bitbucket_resolve_ref(meta$ref %||% ref, meta)

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
    ref = meta$ref %||% ref,
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
  auth <- x$auth_token %||% NULL
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
    RemoteHost = x$host,
    RemoteRepo = x$repo,
    RemoteUsername = x$username,
    RemoteRef = x$ref,
    RemoteSha = sha,
    RemoteSubdir = x$subdir
  )
}


#' @export
remote_package_name.bitbucket_remote <- function(remote, api_version = "1.0", ...) {
  # Downloading specific file is unsupported in version 2.0 of API but is
  # supported in version 1.0 (25 April 2016)
  # https://api.bitbucket.org/1.0/repositories/{accountname}/{repo_slug}/raw/{revision}/{path}
  tmp <- tempfile()
  # Use paste and not file.path as elements of this can be NULL and file.path
  # will barf on NULL
  path <- paste(c("repositories", remote$username, remote$repo, "raw", remote$ref,
    remote$subdir, "DESCRIPTION"), collapse = "/")
  req <- bitbucket_GET(path = path, httr::write_disk(path = tmp),
    api_version = api_version, process_content = FALSE)
  if (httr::status_code(req) >= 400) {
    return(NA)
  }
  read_dcf(tmp)$Package
}

#' @export
remote_sha.bitbucket_remote <- function(remote, url = "https://bitbucket.org", ...) {
  if (!is.null(remote$sha)) {
    return(remote$sha)
  }
  tryCatch({
    git_url <- paste0(url, "/", remote$username, "/", remote$repo, ".git")
    res <- git2r::remote_ls(git_url, ...)
    found <- grep(pattern = paste0("/", remote$ref), x = names(res))
    if (length(found) == 0) {
      return(NA)
    }
    unname(res[found[1]])
  }, error = function(e) NA)
}

