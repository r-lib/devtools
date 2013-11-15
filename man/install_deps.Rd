\name{install_deps}
\alias{install_deps}
\title{Install package dependencies}
\usage{
install_deps(pkg = ".", dependencies = NA)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{dependencies}{\code{logical} indicating to also
  install uninstalled packages which this \code{pkg}
  depends on/links to/suggests. See argument
  \code{dependencies} of \code{\link{install.packages}}.}
}
\description{
  Install package dependencies
}
\examples{
\dontrun{install_deps(".")}
}

