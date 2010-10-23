\name{load_or_library}
\alias{load_or_library}
\title{Load package as development or installed verison.}
\usage{load_or_library(pkg, ...)}

\description{
  Load package as development or installed verison.
}

\details{
  If package exists in known development location on disk,
  load it from there.  Otherwise load the installed package
  with \code{\link{library}}.
}
\keyword{programming}
