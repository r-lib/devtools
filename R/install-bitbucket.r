#' Install a package directly from bitbucket
#'
#' This function is vectorised so you can install multiple packages in
#' a single command.
#'
#' @inheritParams install_github
#' @param auth_user your account username if you're attempting to install
#'   a package hosted in a private repository (and your username is different
#'   to \code{username})
#' @param password your password
#' @param ref Desired git reference; could be a commit, tag, or branch name.
#'   Defaults to master.
#' @seealso Bitbucket API docs:
#'   \url{https://confluence.atlassian.com/bitbucket/use-the-bitbucket-cloud-rest-apis-222724129.html}
#' @family package installation
#' @export
#' @examples
#' \dontrun{
#' install_bitbucket("dannavarro/lsr-package")
#' }
install_bitbucket <- function(repo, username = NULL, ref = "master", subdir = NULL,
                              auth_user = NULL, password = NULL, force = FALSE,
                              quiet = FALSE, ...) {

  remotes <- lapply(repo, bitbucket_remote, username = username, ref = ref,
    subdir = subdir, auth_user = auth_user, password = password)

  if (!isTRUE(force)) {
    remotes <- Filter(function(x) different_sha(x, quiet = quiet), remotes)
  }

  install_remotes(remotes, quiet = quiet, ...)
}

# Copy of code from install_github.R.
# release tag is not supported by Bitbucket
parse_bitbucket_repo <- function(path) {
  username_rx <- "(?:([^/]+)/)?"
  repo_rx <- "([^/@#]+)"
  subdir_rx <- "(?:/([^@#]*[^@#/]))?"
  ref_rx <- "(?:@([^*].*))"
  pull_rx <- "(?:#([0-9]+))"
  ref_or_pull_rx <- sprintf("(?:%s|%s)?", ref_rx, pull_rx)
  bitbucket_rx <- sprintf("^(?:%s%s%s%s|(.*))$",
    username_rx, repo_rx, subdir_rx, ref_or_pull_rx)

  param_names <- c("username", "repo", "subdir", "ref", "pull", "invalid")
  replace <- stats::setNames(sprintf("\\%d", seq_along(param_names)), param_names)
  params <- lapply(replace, function(r) gsub(bitbucket_rx, r, path, perl = TRUE))
  if (params$invalid != "")
    stop(sprintf("Invalid Bitbucket repo: %s", path))
  params <- params[sapply(params, nchar) > 0]

  if (!is.null(params$pull)) {
    params$ref <- bitbucket_pull(params$pull)
    params$pull <- NULL
  }

  params
}

bitbucket_remote <- function(repo, username = NULL, ref = NULL, subdir = NULL,
                              auth_user = NULL, password = NULL, sha = NULL) {

  meta <- parse_bitbucket_repo(repo)
  meta <- bitbucket_resolve_ref(meta$ref %||% ref, meta)

  if (is.null(meta$username)) {
    meta$username <- username %||% stop("Unknown username.")
    warning("Username parameter is deprecated. Please use ",
      username, "/", repo, call. = FALSE)
  }

  remote("bitbucket",
    repo = meta$repo,
    subdir = meta$subdir %||% subdir,
    username = meta$username,
    ref = meta$ref %||% ref,
    sha = sha,
    auth_user = auth_user,
    password = password
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
  # Determine sha as efficiently as possible
  if (!is.null(x$sha)) {
    # Might be cached already (because re-installing)
    sha <- x$sha
  } else if (!is.null(bundle)) {
    # Might be able to get from zip archive
    sha <- git_extract_sha1(bundle)
  } else {
    # Don't know
    sha <- NULL
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
remote_sha.bitbucket_remote <-function(remote, url = "https://bitbucket.org") {
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

#' Bitbucket references
#'
#' Use as \code{ref} parameter to \code{\link{install_bitbucket}}.
#' Allows installing a specific pull request.
#'
#' @param pull The pull request to install
#' @seealso \code{\link{install_bitbucket}}
#' @export
bitbucket_pull <- function(pull) structure(pull, class = "bitbucket_pull")

bitbucket_resolve_ref <- function(x, params) UseMethod("bitbucket_resolve_ref")

#' @export
bitbucket_resolve_ref.default <- function(x, params) {
  params$ref <- x
  params
}

#' @export
bitbucket_resolve_ref.NULL <- function(x, params) {
  params$ref <- "master"
  params
}

#' @export
bitbucket_resolve_ref.bitbucket_pull <- function(x, params, ..., api_version) {
  # GET /repositories/{owner}/{repo_slug}/pullrequests/{id}
  # https://confluence.atlassian.com/bitbucket/pullrequests-resource-423626332.html#pullrequestsResource-GETaspecificpullrequest
  path <- file.path("repositories", params$username, params$repo,
    "pullrequests", x)
  response <- bitbucket_GET(path, ..., host = params$host,
    api_version = api_version)

  params$username <- response$author$username
  params$ref <- response$source$branch$name
  params
}

bitbucket_api_prefix <- function (host = NULL) {
  # https://confluence.atlassian.com/bitbucket/use-the-bitbucket-cloud-rest-apis-222724129.html
  # NB: GET seems to strip out the version suffix to host e.g. GET removes
  # 2.0 from end of api.bitbucket.org/2.0 prior to requesting. So need to
  # incorporate this into downstream functions (particularly as prefix to
  # `path`` arguments)
  host %||% "api.bitbucket.org"
}

bitbucket_GET <- function(path, ..., host = NULL, api_version = "2.0",
  process_content = TRUE) {
  req <- httr::GET(paste0("https://", bitbucket_api_prefix(host)),
    path = file.path(api_version, path), ...)
  if (process_content) {
    bitbucket_response(req)
  } else {
    req
  }
}


bitbucket_response <- function(req) {
  text <- httr::content(req, as = "text")
  parsed <- jsonlite::fromJSON(text, simplifyVector = FALSE)
  # if (httr::status_code(req) >= 400) {
  #   stop(github_error(req))
  # }
  parsed
}

