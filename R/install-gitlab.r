#' Attempts to install a package directly from GitLab
#'
#' This function is vectorised on \code{repo} so you can install multiple
#' packages in a single command. Like other remotes the repository will skip
#' installation if `force == FALSE` (the default) and the remote state has
#' not changed since the previous installation.
#'
#' @inheritParams install_github
#' @param repo Repository address in the format
#'   \code{username/repo[/subdir][@@ref]}.
#' @param host GitLab API host to use. Override with your GitLab enterprise
#'   hostname, for example, \code{"gitlab.hostname.com"}.
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_github("jimhester/covr")
#' }
install_gitlab <- function(repo,
                           auth_token = gitlab_pat(quiet),
                           host = "https://www.gitlab.com", quiet = FALSE, ...)
{

  remotes <- lapply(repo, gitlab_remote, auth_token = auth_token, host = host)

  install_remotes(remotes, quiet = quiet, ...)
}

gitlab_remote <- function(repo,
                       auth_token = gitlab_pat(), sha = NULL,
                       host = "https://www.gitlab.com") {

  meta <- parse_git_repo(repo)
  meta$ref <- meta$ref %||% "master"

  remote("gitlab",
    host = host,
    repo = meta$repo,
    subdir = meta$subdir,
    username = meta$username,
    ref = meta$ref,
    sha = sha,
    auth_token = auth_token
  )
}

#' @export
remote_download.gitlab_remote <- function(x, quiet = FALSE) {
  dest <- tempfile(fileext = paste0(".zip"))

  if (missing_protocol <- !grepl("^[^:]+?://", x$host)) {
    x$host <- paste0("https://", x$host)
  }

  src_root <- paste0(x$host, "/", x$username, "/", x$repo)
  src <- paste0(src_root, "/repository/archive.zip?ref=", utils::URLencode(x$ref, reserved = TRUE))

  if (!quiet) {
    message("Downloading GitLab repo ", x$username, "/", x$repo, "@", x$ref,
            "\nfrom URL ", src)
  }

  if (!is.null(x$auth_token)) {
    auth <- httr::authenticate(
      user = x$auth_token,
      password = "x-oauth-basic",
      type = "basic"
    )
  } else {
    auth <- NULL
  }

  download_gitlab(dest, src, auth)
}

#' @export
remote_metadata.gitlab_remote <- function(x, bundle = NULL, source = NULL) {
  # Determine sha as efficiently as possible
  if (!is.null(bundle)) {
    # Might be able to get from zip archive
    sha <- git_extract_sha1(bundle)
  } else {
    # Otherwise can lookup with remote_ls
    sha <- remote_sha(x)
  }

  list(
    RemoteType = "gitlab",
    RemoteHost = x$host,
    RemoteRepo = x$repo,
    RemoteUsername = x$username,
    RemoteRef = x$ref,
    RemoteSha = sha,
    RemoteSubdir = x$subdir
  )
}

#' @export
remote_package_name.gitlab_remote <- function(remote, url = "https://gitlab.com/", ...) {

  tmp <- tempfile()
  path <- paste(c(
      remote$username,
      remote$repo,
      "raw",
      remote$ref,
      remote$subdir,
      "DESCRIPTION"), collapse = "/")

  if (!is.null(remote$auth_token)) {
    auth <- httr::authenticate(
      user = remote$auth_token,
      password = "x-oauth-basic",
      type = "basic"
    )
  } else {
    auth <- NULL
  }

  # We do not follow redirects because GitLab does a 302 redirect to the sign-in
  # page if the repository does not exist.
  req <- httr::GET(url, path = path, httr::write_disk(path = tmp),
    auth, httr::config(followlocation = FALSE))

  if (httr::status_code(req) >= 300) {
    return(NA_character_)
  }

  read_dcf(tmp)$Package
}

#' @export
remote_sha.gitlab_remote <- function(remote, url = "https://gitlab.com", ...) {
  tryCatch({
    res <- git2r::remote_ls(
      paste0(url, "/", remote$username, "/", remote$repo, ".git"),
      ...)

    found <- grep(pattern = paste0("\\b", remote$ref), x = names(res), perl = TRUE)

    # If none found, assume it is a Sha1, so return the ref
    if (length(found) == 0) {
      return(remote$ref)
    }

    unname(res[found[1]])
  }, error = function(e) NA_character_)
}

#' @export
format.gitlab_remote <- function(x, ...) {
  "GitLab"
}

download_gitlab <- function(path, url, ...) {
  request <- httr::GET(url, ...)

  if (httr::status_code(request) >= 400) {
    stop("Error downloading from GitLab (", httr::status_code(request), ")")
  }

  writeBin(httr::content(request, "raw"), path)
  path
}

#' Retrieve Gitlab personal access token.
#'
#' A github personal access token
#' Looks in env var \code{GITLAB_PAT}
#'
#' @keywords internal
#' @export
gitlab_pat <- function(quiet = FALSE) {
  pat <- Sys.getenv("GITLAB_PAT")
  if (nzchar(pat)) {
    if (!quiet) {
      message("Using GitLab PAT from envvar GITLAB_PAT")
    }
    return(pat)
  }
  return(NULL)
}
