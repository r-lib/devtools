bitbucket_GET <- function(path, ..., host = "https://api.bitbucket.org",
  api_version = "2.0", process_content = TRUE) {
  req <- httr::GET(host, path = file.path(api_version, path), ...)
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

bitbucket_auth <- function (quiet = FALSE) {
  userpwd <- Sys.getenv("BITBUCKET_AUTH")
  if (nzchar(userpwd)) {
    if (!quiet) {
      message("Using user:password from envvar BITBUCKET_AUTH")
    }
    return(userpwd)
  } else {
    return(NULL)
  }
}

parse_repo <- function(path, rx, nms) {
  replace <- stats::setNames(sprintf("\\%d", seq_along(nms)), nms)
  params <- lapply(replace, function(r) gsub(rx, r, path, perl = TRUE))
  if (params$invalid != "")
    stop(sprintf("Invalid repo: %s", path))
  params <- params[sapply(params, nchar) > 0]
  params
}

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
  params <- parse_repo(path, bitbucket_rx, param_names)
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

#' @export
resolve_ref.bitbucket_pull <- function(x, params, ..., api_version) {
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
