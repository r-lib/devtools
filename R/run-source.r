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
#' it has not changed.
#'
#' @param url url
#' @param ... other options passed to \code{\link{source}}
#' @param sha1 The SHA-1 hash of the file at the remote URL
#' @importFrom httr GET stop_for_status text_content
#' @export
#' @examples
#' \dontrun{
#' source_url("https://raw.github.com/gist/1654919/8161f74fb0ec26d1ba9fd54473a96f768ed76f56/test2.r")
#'
#' # With a hash, to make sure the remote file hasn't changed
#' source_url("https://raw.github.com/gist/1654919/8161f74fb0ec26d1ba9fd54473a96f768ed76f56/test2.r",
#'   sha1 = "fc6551f13ceddcbe0730ff74c4300f2682c74028")
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
#' A gist can have multiple files.
#' Gist is based on git, so a gist has commit histories (i.e., revisions).
#' You can specify a commit by giving a SHA of the commit.
#'
#' @param entry either full url (character), gist ID (numeric or character of
#'   numeric). If a gist ID is specified and the entry has multiple files,
#'   only the first file in the gist is sourced.
#' @param ... other options passed to \code{\link{source}}
#' @param sha1 The SHA-1 hash of the file at the remote URL. See
#'   \code{\link{source_url}} for more information on using a SHA-1 hash.
#' @export
#' @examples
#' \dontrun{
#' source_gist(1654919)
#' source_gist("1654919")
#' source_gist("https://gist.github.com/1654919")
#' source_gist("https://gist.github.com/kohske/1654919")
#' source_gist("gist.github.com/1654919")
#' source_gist("https://raw.github.com/gist/1654919/8161f74fb0ec26d1ba9fd54473a96f768ed76f56/test2.r")
#'
#' # With hash to make sure remote file hasn't changed:
#' source_gist("https://gist.github.com/1654919",
#'   sha1 = "aa303f6a9608d7ba2cbee3e28a1191b3caf10b59")
#' }
source_gist <- function(entry, ..., sha1 = NULL) {
  # 1654919 or "1654919"
  if (is.numeric(entry) ||  grepl("^[0-9a-f]+$", entry)) {
    entry <- paste("https://raw.github.com/gist/", entry, sep = "")
  }
  # https://gist.github.com/kohske/1654919, https://gist.github.com/1654919,
  # or gist.github.com/1654919
  else if (grepl("((^https://)|^)gist.github.com/([^/]+/)?[0-9a-f]+$", entry)) {
    entry <- paste("https://raw.github.com/gist/",
      regmatches(entry, regexpr("[0-9a-f]+$", entry)), sep = "")
  }
  print(entry)
  source_url(entry, ..., sha1 = sha1)
}
