\name{pkg_env}
\alias{pkg_env}
\title{Generate an development environment for a package.}
\usage{pkg_env(pkg)}

\description{
  Generate an development environment for a package.
}

\details{
  \code{devtools} keeps the global workspace clean by
  loading all code and data into a separate environment.
  This environment is \code{\link{attach}}ed to the search
  path just after the global environment so it will
  override loaded packages.
}
\keyword{programming}
\arguments{
  \item{pkg}{package description, can be path or package name.  See
\code{\link{as.package}} for more information}
}
