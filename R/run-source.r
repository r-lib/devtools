#' Run a script through some protocols such as http, https, ftp, etc.
#'
#' Internally, \code{source_url} calls \code{\link{getURL}} in
#' \code{RCurl} package and then read the contents by
#' \code{\link{textConnection}}, which is then \code{\link{source}}ed.
#' See \code{?getURL} for the available protocol.
#'
#' If a SHA-1 hash is specified with the \code{sha1} argument, then this
#' function will check the SHA-1 hash of the downloaded file to make sure it
#' matches the expected value, and throw an error if it does not match. If the
#' SHA-1 hash is not specified, it will print a message displaying the hash of
#' the downloaded file. The purpose of this is to improve security when running
#' remotely-hosted code; if you have a hash of the file, you can be sure that
#' it has not changed. For convenience, it is possible to use a truncated SHA1
#' hash, down to 6 characters, but keep in mind that a truncated hash won't be
#' as secure as the full hash.
#'
#' @param url url
#' @param ... other options passed to \code{\link{source}}
#' @param sha1 The (prefix of the) SHA-1 hash of the file at the remote URL.
#' @importFrom httr GET stop_for_status
#' @importFrom digest digest
#' @export
#' @examples
#' \dontrun{
#' 
#' source_url("https://gist.github.com/hadley/6872663/raw/hi.r")
#'
#' # With a hash, to make sure the remote file hasn't changed
#' source_url("https://gist.github.com/hadley/6872663/raw/hi.r",
#'   sha1 = "54f1db27e60bb7e0486d785604909b49e8fef9f9")
#'
#' # With a truncated hash
#' source_url("https://gist.github.com/hadley/6872663/raw/hi.r",
#'   sha1 = "54f1db27e60")
#' }
source_url <- function(url, ..., sha1 = NULL) {
  stopifnot(is.character(url), length(url) == 1)

  temp_file <- tempfile()
  on.exit(unlink(temp_file))

  request <- GET(url)
  stop_for_status(request)
  writeBin(content(request, type = "raw"), temp_file)

  file_sha1 <- digest(file = temp_file, algo = "sha1")

  if (is.null(sha1)) {
    message("SHA-1 hash of file is ", file_sha1)
  } else {
    if (nchar(sha1) < 6) {
      stop("Supplied SHA-1 hash is too short (must be at least 6 characters)")
    }

    # Truncate file_sha1 to length of sha1
    file_sha1 <- substr(file_sha1, 1, nchar(sha1))
    
    if (!identical(file_sha1, sha1)) {
      stop("SHA-1 hash of downloaded file (", file_sha1,
        ")\n  does not match expected value (", sha1, ")", call. = FALSE)
    }
  }

  source(temp_file, ...)
}

#' Run a script on gist
#'
#' \dQuote{Gist is a simple way to share snippets and pastes with others.
#'   All gists are git repositories, so they are automatically versioned,
#'   forkable and usable as a git repository.}
#' \url{https://gist.github.com/}
#'
#' @param id either full url (character), gist ID (numeric or character of
#'   numeric). If a gist ID is specified and the entry has multiple files,
#'   only the first R file in the gist is sourced.
#' @param ... other options passed to \code{\link{source}}
#' @param sha1 The SHA-1 hash of the file at the remote URL. This is highly
#'   recommend as it prevents you from accidentally running code that's not
#'   what you expect. See \code{\link{source_url}} for more information on 
#'   using a SHA-1 hash.
#' @param quiet if \code{FALSE}, the default, prints informative messages.
#' @export
#' @examples
#' # You can run gists given their id
#' source_gist(6872663)
#' source_gist("6872663")
#' 
#' # Or their html url
#' source_gist("https://gist.github.com/hadley/6872663")
#' source_gist("gist.github.com/hadley/6872663")
#'
#' # It's highly recommend that you run source_gist with the optional
#' # sha1 argument - this will throw an error if the file has changed since
#' # you first ran it
#' source_gist(6872663, sha1 = "54f1db27e60")
#' \dontrun{
#' # Wrong hash will result in error
#' source_gist(6872663, sha1 = "54f1db27e61")
#' }
source_gist <- function(id, ..., sha1 = NULL, quiet = FALSE) {
  stopifnot(length(id) == 1)
  
  url_match <- "((^https://)|^)gist.github.com/([^/]+/)?([0-9a-f]+)$"
  if (grepl(url_match, id)) {
    # https://gist.github.com/kohske/1654919, https://gist.github.com/1654919,
    # or gist.github.com/1654919
    id <- regmatches(id, regexec(url_match, id))[[1]][5]
    url <- find_gist(id)
  } else if (is.numeric(id) || grepl("^[0-9a-f]+$", id)) {
    # 1654919 or "1654919"
    url <- find_gist(id)
  } else {
    stop("Unknown id: ", id)
  }

  if (!quiet) message("Sourcing ", url)
  source_url(url, ..., sha1 = sha1)
}

#' @importFrom httr GET stop_for_status add_headers
find_gist <- function(id) {
  url <- sprintf("https://api.github.com/gists/%s", id)
  req <- GET(url, config = add_headers("User-agent" = "hadley/devtools"))
  stop_for_status(req)
  
  # Using regular expression to parse JSON is a bit ick, but it avoid an
  # additional dependency on RJSONIO or similar
  text <- content(req, "text")
  url_pos <- regexec('"raw_url": ?"(.*?\\.[rR])"', text)
  matches <- regmatches(text, url_pos)[[1]]
  
  if (length(matches) != 2) {
    stop("No R files found in gist", call. = FALSE)
  }
  
  matches[2]
}
