\name{load_code}
\alias{load_code}
\title{Load R code.}
\usage{load_code(pkg, env=pkg_env(pkg))}

\description{
  Load R code.
}

\details{
  Load all R code in the \code{R} directory. The first time
  the code is loaded, \code{.onLoad} will be run if it
  exists.
}
\keyword{programming}
\arguments{
  \item{pkg}{package description, can be path or package name.  See
\code{\link{as.package}} for more information}
  \item{env}{environment in which to load code.  Defaults to \code{devel:pkg}
which is attached just after the global environment.  See
\code{\link{pkg_env}} for more information}
}
