\name{load_data}
\alias{load_data}
\title{Load data.}
\usage{
  load_data(pkg = NULL, env = ns_env(pkg))
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{env}{environment in which to load code.  Defaults
  to \code{namespace:pkg} which is a descendent of the
  global environment.  See \code{\link{ns_env}} for more
  information}
}
\description{
  Loads all \code{.Rdata} files in the data subdirectory.
}
\keyword{programming}

