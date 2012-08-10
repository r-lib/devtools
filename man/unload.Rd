\name{unload}
\alias{unload}
\title{Unload a package}
\usage{
  unload(pkg = NULL)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.  See \code{\link{as.package}} for more information}
}
\description{
  Unload a package
}
\examples{
\dontrun{
# Unload package that is in current directory
unload(".")

# Unload package that is in ./ggplot2/
unload("ggplot2/")

# Can use inst() to find the package path
unload(inst("ggplot2"))
}
}

