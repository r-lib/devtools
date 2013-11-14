\name{ns_env}
\alias{ns_env}
\title{Return the namespace environment for a package.}
\usage{
ns_env(pkg = ".")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
  Contains all (exported and non-exported) objects, and is
  a descendent of \code{R_GlobalEnv}. The hieararchy is
  \code{<namespace:pkg>}, \code{<imports:pkg>},
  \code{<namespace:base>}, and then \code{R_GlobalEnv}.
}
\details{
  If the package is not loaded, this function returns
  \code{NULL}.
}
\seealso{
  \code{\link{pkg_env}} for the attached environment that
  contains the exported objects.

  \code{\link{imports_env}} for the environment that
  contains imported objects for the package.
}
\keyword{internal}

