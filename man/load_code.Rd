\name{load_code}
\alias{load_code}
\title{Load R code.}
\usage{
  load_code(pkg = NULL, env = ns_env(pkg))
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
  Load all R code in the \code{R} directory. The first time
  the code is loaded, \code{.onLoad} will be run if it
  exists.
}
\keyword{programming}

