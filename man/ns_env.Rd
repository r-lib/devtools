\name{ns_env}
\alias{ns_env}
\title{Generate a namespace environment for a package.}
\usage{
  ns_env(pkg = NULL)
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
\keyword{programming}

