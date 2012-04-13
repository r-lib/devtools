#' Run a script through some protocols such as http, https, ftp, etc.
#'
#' Internally, \code{source_url} calls \code{\link{getURL}} in
#' \code{RCurl} package and then read the contents by
#' \code{\link{textConnection}}, which is then \code{\link{source}}ed.
#' See \code{?getURL} for the available protocol.
#'
#' @param url url
#' @param ... other options passed to \code{\link{source}}
#' @importFrom httr GET stop_for_status text_content
#' @export
#' @examples
#' \dontrun{
#' source_url("https://raw.github.com/gist/1654919/8161f74fb0ec26d1ba9fd54473a96f768ed76f56/test2.r")
#' }
source_url <- function(url, ...) {
  request <- GET(url)
  stop_for_status(request)
  handle <- textConnection(text_content(request))
  on.exit(close(handle))
  source(handle, ...)
}

#' Run a script on gist
#'
#' \dQuote{Gist is a simple way to share snippets and pastes with others.
#'   All gists are git repositories, so they are automatically versioned,
#'   forkable and usable as a git repository.}
#' \url{https://gist.github.com/}
#'
#' A gist entry can have multiple code blocks (one file for one block).
#' Gist is based on git, which means gist has commit histories (i.e., revisions).
#' You can specify a commit by giving SHA.
#'
#' @param entry either full url (character), gist ID (numeric or character of
#'   numeric). If only an entry ID is specified and the entry has multiple code
#'   block, the first entry is sourced.
#' @param ... other options passed to \code{\link{source}}
#' @export
#' @examples
#' \dontrun{
#' source_gist(1654919)
#' source_gist("1654919")
#' source_gist("https://gist.github.com/1654919")
#' source_gist("gist.github.com/1654919")
#' source_gist("https://raw.github.com/gist/1654919/8161f74fb0ec26d1ba9fd54473a96f768ed76f56/test2.r")
#' }
source_gist <- function(entry, ...) {
  # 1654919 or "1654919"
  if (is.numeric(entry) ||  grepl("^[[:digit:]]+$", entry)) {
    entry <- paste("https://raw.github.com/gist/", entry, sep = "")
  }
  # https://gist.github.com/1899720 or gist.github.com/1899720
  else if (grepl("((^https://)|^)gist.github.com/[[:digit:]]+$", entry)) {
    entry <- paste("https://raw.github.com/gist/", regmatches(entry, regexpr("[[:digit:]]+$", entry)), sep = "")
  }
  source_url(entry, ...)
}
