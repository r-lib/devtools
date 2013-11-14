\name{inst}
\alias{inst}
\title{Get the installation path of a package}
\usage{
inst(name)
}
\arguments{
  \item{name}{the name of a package.}
}
\description{
  Given the name of a package, this returns a path to the
  installed copy of the package, which can be passed to
  other devtools functions.
}
\details{
  It searches for the package in \code{\link{.libPaths}()}.
  If multiple dirs are found, it will return the first one.
}
\examples{
inst("devtools")
inst("grid")
\dontrun{
# Can be passed to other devtools functions
unload(inst("ggplot2"))
}
}

