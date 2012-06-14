\name{source_gist}
\alias{source_gist}
\title{Run a script on gist}
\usage{
  source_gist(entry, ...)
}
\arguments{
  \item{entry}{either full url (character), gist ID
  (numeric or character of numeric). If only an entry ID is
  specified and the entry has multiple code block, the
  first entry is sourced.}

  \item{...}{other options passed to \code{\link{source}}}
}
\description{
  \dQuote{Gist is a simple way to share snippets and pastes
  with others.  All gists are git repositories, so they are
  automatically versioned, forkable and usable as a git
  repository.} \url{https://gist.github.com/}
}
\details{
  A gist entry can have multiple code blocks (one file for
  one block). Gist is based on git, which means gist has
  commit histories (i.e., revisions). You can specify a
  commit by giving SHA.
}
\examples{
\dontrun{
source_gist(1654919)
source_gist("1654919")
source_gist("https://gist.github.com/1654919")
source_gist("gist.github.com/1654919")
source_gist("https://raw.github.com/gist/1654919/8161f74fb0ec26d1ba9fd54473a96f768ed76f56/test2.r")
}
}

