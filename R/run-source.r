#' Run a script via https
#'
#' @param url url
#' @param ... other options passed to \code{\link{source}}
#' @importFrom RCurl getURL
#' @export
source_https <- function(url, ...) {
  message("Running: ", url)
  source(textConnection(getURL(url)), ...)
}

#' Run a script on gist
#'
#' \dQuote{Gist is a simple way to share snippets and pastes with others. All gists are git repositories, so they are automatically versioned, forkable and usable as a git repository. \url{https://gist.github.com/}}
#'
#' A gist entry can have multiple code blocks (one file for one block).
#' Gist is based on git, which means gist has commit histories (i.e., revisions). You can specify a commit by ginving SHA.
#'
#' @param entry either full url (character), gist ID (numeric or character of numeric).
#'   If only an entry ID is specified and the entry has multiple code block, the first entry is sourced.
#' @param ... other options passed to \code{\link{source}}
#' @export
#' @examples
#' \dontrun{
#' source_gist(1654919)
#' source_gist("1654919")
#' source_gist("https://raw.github.com/gist/1654919/8161f74fb0ec26d1ba9fd54473a96f768ed76f56/test2.r")
#' }
source_gist <- function(entry, ...) {
  if (is.numeric(entry) ||  grepl("^[[:digit:]]+$", entry))
    entry <- paste("https://raw.github.com/gist/", entry, sep = "")
  source_https(entry, ...)
}
