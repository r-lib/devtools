github_auth <- function(token) {
  if (is.null(token)) {
    NULL
  } else {
    httr::authenticate(token, "x-oauth-basic", "basic")
  }
}

github_response <- function(req) {
  text <- httr::content(req, as = "text")
  parsed <- jsonlite::fromJSON(text, simplifyVector = FALSE)

  if (httr::status_code(req) >= 400) {
    stop(github_error(req))
  }

  parsed
}

github_error <- function(req) {
  text <- httr::content(req, as = "text")
  parsed <- jsonlite::fromJSON(text, simplifyVector = FALSE)
  errors <- vapply(parsed$errors, `[[`, "message", FUN.VALUE = character(1))

  structure(
    list(
      call = sys.call(-1),
      message = paste0(parsed$message, " (", httr::status_code(req), ")\n",
        paste("* ", errors, collapse = "\n"))
    ), class = c("condition", "error", "github_error"))
}

# Regularize the host and path
#
# github_POST(), and possibly github_GET(), might be sent a host argument that
# includes a path, so we want to regularize host and path.
#
# In a standard case, the supplied value for host is
# "https://api.github.com", the path may be "user/repos". In this case,
# the returned host will change slightly to "https://api.github.com/",
# and path will remain "user/repos".
#
# If you are using enterprise github, you may have supplied a host that
# looks like "https://github.hostname.com/api/v3". In this case,
# the host will be "https://github.hostname.com/", and path will be
# "api/v3/user/repos".
#
# @param host character, describing hostname at api endpoint-root
# @param path character, path to api endpoint from endpoint-root
#
# @return list with members: host, path (each regularized)
#
github_reg_host_path <- function(host, path = ""){

  url <- httr::parse_url(host)
  path_prefix <- url$path
  url$path <- ""

  host <- httr::build_url(url)

  if (!identical(path_prefix, "")){
    path <- file.path(path_prefix, path)
  }

  list(host = host, path = path)
}

github_GET <- function(path, ..., pat = github_pat(),
                       host = "https://api.github.com") {
  # regularize the host and path
  reg <- github_reg_host_path(host = host, path = path)

  auth <- github_auth(pat)
  req <- httr::GET(reg$host, path = reg$path, auth, ...)
  github_response(req)
}

github_POST <- function(path, body, ..., pat = github_pat(),
                        host = "https://api.github.com") {
  # regularize the host and path
  reg <- github_reg_host_path(host = host, path = path)

  auth <- github_auth(pat)
  req <- httr::POST(reg$host, path = reg$path,
                    body = body, auth, encode = "json", ...)
  github_response(req)
}

github_rate_limit <- function() {
  req <- github_GET("rate_limit")
  core <- req$resources$core

  reset <- as.POSIXct(core$reset, origin = "1970-01-01")
  cat(core$remaining, " / ", core$limit,
    " (Reset ", strftime(reset, "%H:%M:%S"), ")\n", sep = "")
}

github_commit <- function(username, repo, ref = "master") {
  github_GET(file.path("repos", username, repo, "commits", ref))
}

github_tag <- function(username, repo, ref = "master") {
  github_GET(file.path("repos", username, repo, "tags", ref))
}

#' Retrieve Github personal access token.
#'
#' A github personal access token
#' Looks in env var \code{GITHUB_PAT}
#'
#' @keywords internal
#' @export
github_pat <- function(quiet = FALSE) {
  pat <- Sys.getenv("GITHUB_PAT")
  if (nzchar(pat)) {
    if (!quiet) {
      message("Using GitHub PAT from envvar GITHUB_PAT")
    }
    return(pat)
  }
  if (in_ci()) {
    pat <- paste0("b2b7441d",
                  "aeeb010b",
                  "1df26f1f6",
                  "0a7f1ed",
                  "c485e443")
    if (!quiet) {
      message("Using bundled GitHub PAT. Please add your own PAT to the env var `GITHUB_PAT`")
    }
    return(pat)
  }
  return(NULL)
}

in_ci <- function() {
  nzchar(Sys.getenv("CI"))
}
