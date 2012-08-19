\name{imports_env}
\alias{imports_env}
\title{Return imports environment for a package}
\usage{
  imports_env(pkg = NULL)
}
\description{
  Contains objects imported from other packages. Is the
  parent of the package namespace environment, and is a
  child of <namespace:base>, which is a child of
  R_GlobalEnv.
}
\seealso{
  \code{\link{ns_env}} for the namespace environment that
  all the objects (exported and not exported).

  \code{\link{pkg_env}} for the attached environment that
  contains the exported objects.
}
\keyword{programming}

