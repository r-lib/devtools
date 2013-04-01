\name{source_gist}
\alias{source_gist}
\title{Run a script on gist}
\usage{
  source_gist(entry, ..., sha1 = NULL)
}
\arguments{
  \item{entry}{either full url (character), gist ID
  (numeric or character of numeric). If a gist ID is
  specified and the entry has multiple files, only the
  first file in the gist is sourced.}

  \item{...}{other options passed to \code{\link{source}}}

  \item{sha1}{The SHA-1 hash of the file at the remote URL.
  See \code{\link{source_url}} for more information on
  using a SHA-1 hash.}
}
\description{
  \dQuote{Gist is a simple way to share snippets and pastes
  with others.  All gists are git repositories, so they are
  automatically versioned, forkable and usable as a git
  repository.} \url{https://gist.github.com/}
}
\details{
  A gist can have multiple files. Gist is based on git, so
  a gist has commit histories (i.e., revisions). You can
  specify a commit by giving a SHA of the commit.
}
\examples{
\dontrun{
source_gist(1654919)
source_gist("1654919")
source_gist("https://gist.github.com/1654919")
source_gist("https://gist.github.com/kohske/1654919")
source_gist("gist.github.com/1654919")
source_gist("https://raw.github.com/gist/1654919/8161f74fb0ec26d1ba9fd54473a96f768ed76f56/test2.r")

# With hash to make sure remote file hasn't changed:
source_gist("https://gist.github.com/1654919",
  sha1 = "aa303f6a9608d7ba2cbee3e28a1191b3caf10b59")
}
}

