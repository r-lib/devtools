\name{install}
\alias{install}
\title{Install a package.}
\usage{install(pkg, reload=TRUE)}

\description{
  Install a package.
}

\details{
  Uses \code{R CMD INSTALL} to install the package. Will
  also try to install dependencies of the package from
  CRAN, if they're not already installed.

  Installation takes place on a copy of the package
  produced by \code{R CMD build} to avoid modifying the
  local directory in any way.
}
\arguments{
  \item{pkg}{package description, can be path or package name.  See
\code{\link{as.package}} for more information}
  \item{reload}{if \code{TRUE} (the default), will automatically reload the 
package after installing.}
}
