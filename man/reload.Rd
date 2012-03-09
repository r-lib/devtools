\name{reload}
\alias{reload}
\title{Detach and reload package.}
\usage{
  reload(pkg = NULL)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
  If the package is not loaded already, this does nothing.
}
\details{
  See the caveats in \code{\link{detach}} for the many
  reasons why this might not work. If in doubt, quit R and
  restart.
}

