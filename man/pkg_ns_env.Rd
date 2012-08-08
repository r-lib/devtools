\name{pkg_ns_env}
\alias{pkg_ns_env}
\title{Generate an development namespace environment for a package.}
\usage{
  pkg_ns_env(pkg = NULL)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
  Contains all (exported and non-exported) objects, and is
  a child of R_GlobalEnv.
}
\details{
  \code{devtools} keeps the global workspace clean by
  loading all code and data into a separate environment.
  This environment is \code{\link{attach}}ed to the search
  path just after the global environment so it will
  override loaded packages.
}
\keyword{programming}

