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
  text <- httr::content(req, as = "text", encoding = "UTF-8")
  parsed <- tryCatch(jsonlite::fromJSON(text, simplifyVector = FALSE),
    error = function(e) {
      list(message = text)
    }
  )
  errors <- vapply(parsed$errors, `[[`, "message", FUN.VALUE = character(1))

  structure(
    list(
      call = sys.call(-1),
      message = paste0(
        parsed$message, " (", httr::status_code(req), ")\n",
        if (length(errors) > 0) {
          paste("* ", errors, collapse = "\n")
        }
      )
    ),
    class = c("condition", "error", "github_error")
  )
}

github_GET <- function(path, ..., pat = github_pat(),
                       host = "https://api.github.com") {
  url <- httr::parse_url(host)
  url$path <- paste(url$path, path, sep = "/")
  ## May remove line below at release of httr > 1.1.0
  url$path <- gsub("^/", "", url$path)
  ##
  req <- httr::GET(url, github_auth(pat), ...)
  github_response(req)
}

github_POST <- function(path, body, ..., pat = github_pat(),
                        host = "https://api.github.com") {
  url <- httr::parse_url(host)
  url$path <- paste(url$path, path, sep = "/")
  ## May remove line below at release of httr > 1.1.0
  url$path <- gsub("^/", "", url$path)
  ##
  req <- httr::POST(url, body = body, github_auth(pat), encode = "json", ...)
  github_response(req)
}

github_rate_limit <- function() {
  req <- github_GET("rate_limit")
  core <- req$resources$core

  reset <- as.POSIXct(core$reset, origin = "1970-01-01")
  cat(core$remaining, " / ", core$limit,
    " (Reset ", strftime(reset, "%H:%M:%S"), ")\n",
    sep = ""
  )
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
github_pat <- function(quiet = TRUE) {
  pat <- Sys.getenv("GITHUB_PAT")
  if (nzchar(pat)) {
    if (!quiet) {
      message("Using GitHub PAT from envvar GITHUB_PAT")
    }
    return(pat)
  }
  if (in_ci()) {
    pat <- paste0(
      "b2b7441d",
      "aeeb010b",
      "1df26f1f6",
      "0a7f1ed",
      "c485e443"
    )
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

github_user <- memoise::memoise(function(..., pat = github_pat(), host = "https://api.github.com") {
  github_GET("/user", ...)[["login"]]
})
