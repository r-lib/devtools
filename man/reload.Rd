\name{reload}
\alias{reload}
\title{Unload and reload package.}
\usage{
  reload(pkg = ".")
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
\examples{
\dontrun{
# Reload package that is in current directory
reload(".")

# Reload package that is in ./ggplot2/
reload("ggplot2/")

# Can use inst() to find the package path
# This will reload the installed ggplot2 package
reload(inst("ggplot2"))
}
}

