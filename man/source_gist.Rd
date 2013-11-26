\name{source_gist}
\alias{source_gist}
\title{Run a script on gist}
\usage{
source_gist(id, ..., sha1 = NULL, quiet = FALSE)
}
\arguments{
  \item{id}{either full url (character), gist ID (numeric
  or character of numeric). If a gist ID is specified and
  the entry has multiple files, only the first R file in
  the gist is sourced.}

  \item{...}{other options passed to \code{\link{source}}}

  \item{sha1}{The SHA-1 hash of the file at the remote URL.
  This is highly recommend as it prevents you from
  accidentally running code that's not what you expect. See
  \code{\link{source_url}} for more information on using a
  SHA-1 hash.}

  \item{quiet}{if \code{FALSE}, the default, prints
  informative messages.}
}
\description{
\dQuote{Gist is a simple way to share snippets and pastes
with others.  All gists are git repositories, so they are
automatically versioned, forkable and usable as a git
repository.} \url{https://gist.github.com/}
}
\examples{
# You can run gists given their id
source_gist(6872663)
source_gist("6872663")

# Or their html url
source_gist("https://gist.github.com/hadley/6872663")
source_gist("gist.github.com/hadley/6872663")

# It's highly recommend that you run source_gist with the optional
# sha1 argument - this will throw an error if the file has changed since
# you first ran it
source_gist(6872663, sha1 = "54f1db27e60")
\dontrun{
# Wrong hash will result in error
source_gist(6872663, sha1 = "54f1db27e61")
}
}

