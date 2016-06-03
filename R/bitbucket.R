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

bitbucket_host <- function (host = NULL) {
  # https://confluence.atlassian.com/bitbucket/use-the-bitbucket-cloud-rest-apis-222724129.html
  # NB: GET seems to strip out the version suffix to host e.g. GET removes
  # 2.0 from end of api.bitbucket.org/2.0 prior to requesting. So need to
  # incorporate this into downstream functions (particularly as prefix to
  # `path`` arguments)
  host %||% "api.bitbucket.org"
}

bitbucket_GET <- function(path, ..., host = NULL, api_version = "2.0",
  process_content = TRUE) {
  req <- httr::GET(paste0("https://", bitbucket_host(host)),
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
  if (httr::status_code(req) >= 400) {
    stop(bitbucket_error(req))
  }
  parsed
}

bitbucket_error <- function(req) {
  text <- httr::content(req, as = "text")
  parsed <- jsonlite::fromJSON(text, simplifyVector = FALSE)
  errors <- vapply(parsed, `[[`, "message", FUN.VALUE = character(1))

  structure(
    list(
      call = sys.call(-1),
      message = paste0("(", httr::status_code(req), ")\n",
        paste("* ", errors, collapse = "\n"))
    ), class = c("condition", "error", "bitbucket_error"))
}

#' @export
format.bitbucket_remote <- function(x, ...) {
  "Bitbucket"
}

bitbucket_consumer_key <- function () {
  Sys.getenv("BITBUCKET_CONSUMER_KEY")
}

bitbucket_oauth_app <- function (key = bitbucket_consumer_key()) {
  httr::oauth_app("bitbucket", key)
}

bitbucket_oauth_endpoint <- function () {
  httr::oauth_endpoint(authorize = "authorize", access = "access_token",
    base_url = "https://bitbucket.org/site/oauth2")
}

bitbucket_pat <- function (key = bitbucket_consumer_key()) {
  # Only OAuth2.0 supported
  if (file.exists("~/.httr-oauth")) {
    httr::oauth2.0_token(bitbucket_oauth_endpoint(),
      bitbucket_oauth_app(), cache = "~/.httr-oauth")
  } else {
    message("Caching access token in ~/.httr-oauth")
    on.exit(setwd(getwd()))
    setwd("~/")
    httr::oauth2.0_token(bitbucket_oauth_endpoint(), bitbucket_oauth_app())
  }
}
