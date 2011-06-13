\name{install}
\alias{install}
\title{Install a package.}
\usage{install(pkg)}

\description{
  Install a package.
}

\details{
  Uses \code{R CMD install} to install the package. Will
  also try to install dependencies of the package from
  CRAN, if they're not already installed.
}
\arguments{
  \item{pkg}{package description, can be path or package name.  See
\code{\link{as.package}} for more information}
}
