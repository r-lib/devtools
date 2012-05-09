\name{set_path}
\alias{set_path}
\title{Set the path from a vector of individual paths.}
\usage{
  set_path(path)
}
\arguments{
  \item{path}{character vector of locations}
}
\value{
  invisibly returns the old path.
}
\description{
  Set the path from a vector of individual paths.
}
\note{
  This only works for the current session.  The path is not
  set permanently.
}
\seealso{
  Other path: \code{\link{add_path}},
  \code{\link{get_path}}, \code{\link{on_path}}
}

