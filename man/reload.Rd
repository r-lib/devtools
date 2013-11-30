\name{reload}
\alias{reload}
\title{Unload and reload package.}
\usage{
reload(pkg = ".", quiet = FALSE)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}

  \item{quiet}{if \code{TRUE} suppresses output from this
  function.}
}
\description{
This attempts to unload and reload a package. If the
package is not loaded already, it does nothing. It's not
always possible to cleanly unload a package: see the
caveats in \code{\link{unload}} for the some of the
potential failure points. If in doubt, restart R and reload
the package with \code{\link{library}}.
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

