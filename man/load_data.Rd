\name{load_data}
\alias{load_data}
\title{Load data.}
\usage{
  load_data(pkg = NULL, env = pkg_env(pkg))
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{env}{environment in which to load code.  Defaults
  to \code{devel:pkg} which is attached just after the
  global environment.  See \code{\link{pkg_env}} for more
  information}
}
\description{
  Loads all \code{.Rdata} files in the data subdirectory.
}
\keyword{programming}

