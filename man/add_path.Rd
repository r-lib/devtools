\name{add_path}
\alias{add_path}
\title{Add a location to the Path variable.}
\usage{
  add_path(..., after = Inf)
}
\arguments{
  \item{...}{character locations}

  \item{after}{the place on the path, defaults to the end}
}
\value{
  invisibly returns the old path.
}
\description{
  Temporarily adds a location to the path.
}
\seealso{
  Other path: \code{\link{get_path}},
  \code{\link{on_path}}, \code{\link{set_path}}
}

